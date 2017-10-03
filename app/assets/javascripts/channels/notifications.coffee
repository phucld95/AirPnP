$(() ->
  # user_id: from application.html.erb
  App.notifications = App.cable.subscriptions.create {channel: "NotificationsChannel", id: $('#user_id').val()},
    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      $('#notifications').prepend(data.message)
      $('#number_of_unread').html(data.unread)
)
