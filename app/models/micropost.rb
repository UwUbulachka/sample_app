class Micropost < ApplicationRecord
  belongs_to :user #посты пренадлежат пользователю
  default_scope -> { order(created_at: :desc) } #по умалчанию порядок по убыванию
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true #проверят индификатор пользователя должен присутствовать
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
 
  private

  def picture_size
    if picture.size > 5 megabytes 
      errors.add(:picture, "should be less than 5MB") 
    end
  end
end
