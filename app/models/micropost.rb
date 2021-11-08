class Micropost < ApplicationRecord
  belongs_to :user #посты пренадлежат пользователю
  default_scope -> { order(created_at: :desc) } #по умалчанию порядок по убыванию
  validates :user_id, presence: true #проверят индификатор пользователя должен присутствовать
  validates :content, presence: true, length: { maximum: 140 }
end
