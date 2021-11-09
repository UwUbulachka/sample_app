class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #защищать от подделки за исключением
  include SessionsHelper #подключения модуля Sessions для доступа во всех ктроллерах
  
  private 

  # Подтверждает вход пользователя.
  def logged_in_user
    unless logged_in? #пока пользователь не войдет 
      store_location #запомини url
      flash[:danger] = "Please log in." 
      redirect_to login_url #перенаправляй на страницу регистрации
    end
  end
end
