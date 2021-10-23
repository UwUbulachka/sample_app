ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper #подключем метод full title что бы можно было протестировать
  
  # Возвращает true, если тестовый пользователь вошел.
  def is_logged_in?
    !session[:user_id].nil? #не должен быть пустым текущий пользователь
  end


  # Выполняет вход тестового пользователя.
  def log_in_as(user, options = {})
    password = options[:password] || 'password' #присвоит значение указанного параметра при его наличии либо значение по умолчанию 1
    remember_me = options[:remember_me] || '1'
      post login_path, params: {session: { email: user.email, # Выполнить вход отправкой запроса post
                                              password: password,
                                              remember_me: remember_me }}
    
  end
end
