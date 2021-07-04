class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  
  validates :comment, presence: {message: "#未入力"}
  validates :comment, length: { maximum: 250, message: "#250字以内まで"}
  
end
