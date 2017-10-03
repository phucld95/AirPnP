class GuestReview < Review
  belongs_to :guest, class_name: User.name
end
