class Conversation < ApplicationRecord
  # belongs_to :sender, foreign_key: :sender_id, class_name: User.name
  # belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  belongs_to :sender, foreign_key: "sender_id", class_name: "User"
  belongs_to :recipient, foreign_key: "recipient_id", class_name: "User"

  has_many :messages, dependent: :destroy
  # Conversation should be unique
  # validates_uniqueness_of :sender_id, :recipient_id
  validates_uniqueness_of :sender_id, :scope => [:recipient_id]
  scope :involving, -> (user) {
    where("conversations.sender_id = ? OR conversations.recipient_id = ?", user.id, user.id)
  }

  # user_A and user_B are id
  scope :between, -> (user_A, user_B) {
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?)
      OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", user_A, user_B, user_B, user_A)
  }
  # scope :between, -> (user_A, user_B) {
  #   where("(conversations.sender_id = ? OR conversations.recipient_id = ?) OR conversations.sender_id = ? OR conversations.recipient_id = ?", user_A, user_B, user_B, user_A)
  # }
end
