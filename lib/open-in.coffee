OpenInView = require './open-in-view'

{exec} = require 'child_process'

module.exports =
  openInView: null
  configDefaults:
    GitHub: true
    SourceTree: true

  activate: (state) ->
    @openInView = new OpenInView(state.openInViewState)
    if atom.config.get('open-in.GitHub')
      atom.workspaceView.command 'open-in:GitHub', => @open('GitHub')

    if atom.config.get('open-in.SourceTree')
      atom.workspaceView.command 'open-in:SourceTree', => @open('SourceTree')

  error: (message) ->
    @openInView.message(message)

  open: (app) ->
    projectPath = atom.project?.getPath()
    open = exec "open -a #{app}.app #{projectPath}"

    open.stderr.on 'data', (data) =>
      @error("Unable to find application #{app}")