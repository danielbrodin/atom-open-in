{$$, SelectListView} = require 'atom'
{exec} = require 'child_process'

module.exports =
class OpenInAppView extends SelectListView
  type: null

  activate: ->
    new OpenInAppView

  initialize: (serializeState) ->
    super
    @addClass 'open-in overlay from-top'

  serialize: ->

  getFilterKey: -> 'title'

  destroy: -> @detach()

  toggle: (type) ->
    @type = type
    if @hasParent()
      @cancel()
    else
      @attach()

  attach: ->
    apps = atom.config.get('open-in.applications').split(',')
    @setItems apps

    atom.workspaceView.append(@)
    @focusFilterEditor()

  viewForItem: (app) ->
    $$ ->
      @li class: 'open-in-item', app

  confirmed: (app) =>
    @cancel()

    switch @type
      when 'Project'
        path = atom.project?.getPath()

      when 'Current file'
        atom.workspace.eachEditor (editor) =>
          path = editor.getPath()

    console.log @type
    console.log app
    console.log path

    if path?
      open = exec "open -a #{app} #{path}"

      open.stderr.on 'data', (data) =>
        alert "Unable to find application #{app}"