class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #взаимотношения имеют одного читающего пользователя
  belongs_to :followed, class_name: "User"
end
