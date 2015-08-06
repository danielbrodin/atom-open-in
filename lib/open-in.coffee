module.exports =
  config:
    applications:
      type: 'string'
      default: 'GitHub,Terminal'

  openInView: null

  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'open-in:toggle': =>
        @createView().toggle()

  createView: =>
    unless @openInView
      OpenInView = require './open-in-view'
      @openInView = new OpenInView()
    @openInView
