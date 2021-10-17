class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #защищать от подделки за исключением
  include SessionsHelper #подключения модуля Sessions для доступа во всех ктроллерах
end
