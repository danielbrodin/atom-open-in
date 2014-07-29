module.exports =
  configDefaults:
    applications: 'GitHub,Terminal'

  openInView: null

  activate: (state) ->
    atom.workspaceView.command 'open-in:toggle', =>
      @createView().toggle()

  createView: =>
    unless @openInView
      OpenInView = require './open-in-view'
      @openInView = new OpenInView()
    @openInView