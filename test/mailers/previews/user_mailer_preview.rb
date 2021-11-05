# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first #присвоить первого пользавателя
    user.activation_token = User.new_token #создать токен для пераого пользователя
    UserMailer.account_activation(user) #активировать аккаун по токену первого пользователя
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset  
  end

end
