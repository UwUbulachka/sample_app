class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #взаимотношения имеют одного читающего пользователя
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
