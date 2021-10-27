class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! } #до сохранения переведи метод email в нижний ригистр (можно записать так before_save{self.email = email.downcase})
  validates :name, presence: true, length: {maximum: 50} #проверяет: имя, присутствие: истина
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #регулярное выражение
  validates :email, presence: true, length: {maximum: 255},
                                    format: {with: VALID_EMAIL_REGEX}, #проверка формата 
                                    uniqueness: {case_sensitive: false} #уникальность чувствительна к регистру ложь
  has_secure_password #имеет надежный пароль
  validates :password, length: {minimum: 6}, allow_blank: true #минимальная длинна пороля разрешить пустое значение true



  # Возвращает дайджест для указанной строки. Хеширует пороль переменной string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
            BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Возвращает случайный токен.
  def User.new_token
    SecureRandom.urlsafe_base64
  end 

  # Запоминает пользователя в базе данных для использования в постоянных сеансах.
  def remember
    self.remember_token = User.new_token #присваевает перемменой (запомнить токен) новый созданный токен
    update_attribute(:remember_digest, User.digest(remember_token)) #обновляет запомненный дайджест и и обновляет токен (хеширует новый запоненный токен)
  end 

  # Возвращает true, если указанный токен соответствует дайджесту.
  def authenticated?(remember_token)
    return false if remember_digest.nil? #вернуть false , если дайджест равен nil
    BCrypt::Password.new(remember_digest).is_password?(remember_token) #хешированный токен из бд должен быть равен токену пользователя (тоже самое BCrypt::Password.new(remember_digest) == remember_token)
  end

  # Забывает пользователя
  def forget
    update_attribute(:remember_digest, nil) #присваивая дайджесту значение nil   
  end 
end
