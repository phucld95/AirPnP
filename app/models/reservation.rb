class Reservation < ApplicationRecord
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  after_create_commit :create_notification

  belongs_to :user
  belongs_to :room

  # scope: approved_reservations, ~> (status) { where(status: status)}

  # use update before reservations have waited from host
  scope :current_week_revenue, -> (user) {
    joins(:room)
    .where("rooms.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private
  def create_notification
    type = self.room.Instant? ? "New Booking" : "New Request"
    guest = User.find_by id: self.user_id
    Notification.create(
      content: "#{type} from #{guest.fullname}",
      user_id: self.room.user_id
    )
  end
end
