App.public_messages = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    console.log 'Connected to MessageChannel'

  disconnected: ->
    console.log 'Disconnected from MessageChannel'

  received: (data) ->
    console.log data
    $("#all_messages").prepend data.message

  speak: (message) ->
    @perform 'speak', message: message
