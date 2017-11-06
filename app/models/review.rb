class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
