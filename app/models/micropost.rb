class Micropost < ApplicationRecord
  belongs_to :user #посты пренадлежат пользователю
  validates :user_id, presence: true #проверят индификатор пользователя должен присутствовать
  validates :content, presence: true, length: { maximum: 140 }
end
