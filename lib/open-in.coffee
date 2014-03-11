{exec} = require 'child_process'


module.exports =
  configDefaults:
    GitHub: true
    SourceTree: true

  activate: ->
    if atom.config.get('open-in.GitHub')
      atom.workspaceView.command 'open-in:GitHub', => @open('GitHub')

    if atom.config.get('open-in.SourceTree')
      atom.workspaceView.command 'open-in:SourceTree', => @open('SourceTree')

  open: (app) ->
    console.log app
    projectPath = atom.project?.getPath()
    open = exec "open -a #{app}.app #{projectPath}"

    open.stderr.on 'data', (data) ->
      console.log "stderr: #{data}"