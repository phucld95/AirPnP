$(() ->
  App.messages = App.cable.subscriptions.create {channel: 'MessagesChannel', id: $('#conversation_id').val()},
    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      $('#new_message')[0].reset()
      $('#chat').prepend data.message

)
