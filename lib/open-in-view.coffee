{View} = require 'atom'

module.exports =
class OpenIn extends View
  @content: ->
    @div class: 'open-in overlay from-top', =>
      @div class: 'message error-messages', =>
        @i class: 'icon icon-alert'
        @span 'Could not find application', class: 'open-in-message'

  initialize: (serializeState) ->

  message: (message) ->
    if @hasParent()
      @detach()
    else
      this.find('.open-in-message').text message
      atom.workspaceView.append this
      setTimeout @destroy, 4000

  destroy: ->
    atom.workspaceView.find('.open-in').remove()
    @detach