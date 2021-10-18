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
end
