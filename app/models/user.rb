class User < ApplicationRecord
  before_save { email.downcase! } #до сохранения переведи метод email в нижний ригистр (можно записать так before_save{self.email = email.downcase})
  validates :name, presence: true, length: {maximum: 50} #проверяет: имя, присутствие: истина
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #регулярное выражение
  validates :email, presence: true, length: {maximum: 255},
                                    format: {with: VALID_EMAIL_REGEX}, #проверка формата 
                                    uniqueness: {case_sensitive: false} #уникальность чувствительна к регистру ложь
  has_secure_password #имеет надежный пароль
  validates :password, length: {minimum: 6} #минимальная длинна пороля
end
