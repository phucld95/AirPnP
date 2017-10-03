class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Do something later
    # Incre unread to 1
    notification.user.increment!(:unread)
    # Broadcast message and unread to coffee file
    ActionCable.server.broadcast "notification_#{notification.user.id}", message: render_notification(notification), unread: notification.user.unread
  end

  private
  def render_notification notification
    ApplicationController.render(partial: "notifications/notification", locals: {notification: notification})
  end
end
