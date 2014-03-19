OpenIn = require '../lib/open-in'
{WorkspaceView} = require 'atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "OpenIn", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('open-in')

  describe "when the open-in:HibGub event is triggered", ->
    it "attaches and then detaches the view", ->
      #expect(atom.workspaceView.find('.open-in')).toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      #atom.workspaceView.command 'open-in:HibGub', => @open('HibGub')
      atom.workspaceView.trigger 'open-in:HibGub'

      waitsForPromise ->
        expect(atom.workspaceView.find('.open-in')).toExist()
        #activationPromise

      runs ->
        expect(atom.workspaceView.find('.open-in')).not.toExist()
        atom.workspaceView.trigger 'open-in:HibGub'
        expect(atom.workspaceView.find('.open-in')).toExist()