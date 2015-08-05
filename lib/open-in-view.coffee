{$$, SelectListView} = require 'atom-space-pen-views'

module.exports =
class OpenInView extends SelectListView
  type: null

  activate: ->
    new OpenInView

  initialize: (serializeState) ->
    super
    @addClass 'open-in'

  cancelled: ->
    @hide()

  serialize: ->

  getFilterKey: -> 'title'

  destroy: -> @detach()

  hide: ->
    @panel?.hide()

  show: ->
    @panel ?= atom.workspace.addModalPanel(item: this)
    @panel.show()

    @storeFocusedElement()

    types = ['Project', 'Current file']
    @setItems types

    @focusFilterEditor()

  toggle: () ->
    if @panel?.isVisible()
      @cancel()
    else
      @show()

  viewForItem: (type) ->
    $$ ->
      @li class: 'open-in-item', =>
        @div class: "icon icon-chevron-right pull-right", ""
        @div =>
          @span "Open "
          @b class:"text-highlight", type
          @span " in..."

  confirmed: (type) =>
    @cancel()
    @createOpenInAppView().toggle(type)

  createOpenInAppView: ->
    unless @openInAappView
      OpenInAppView = require './open-in-app-view'
      @openInAppView = new OpenInAppView()
    @openInAppView
