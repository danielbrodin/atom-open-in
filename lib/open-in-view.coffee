{$$, SelectListView} = require 'atom'

module.exports =
class OpenInView extends SelectListView
  type: null

  activate: ->
    new OpenInView

  initialize: (serializeState) ->
    super
    @addClass 'open-in overlay from-top'

  serialize: ->

  getFilterKey: -> 'title'

  destroy: -> @detach()

  toggle: () ->
    if @hasParent()
      @cancel()
    else
      @attach()

  attach: ->
    types = ['Project', 'Current file']
    @setItems types

    atom.workspaceView.append(@)
    @focusFilterEditor()

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

