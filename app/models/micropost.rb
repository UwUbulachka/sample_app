class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #проверят индификатор пользователя должен присутствовать
  validates :content, presence: true, length: { maximum: 140 }
end
