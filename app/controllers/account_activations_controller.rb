class AccountActivationsController < ApplicationController	

  def edit
  	user = User.find_by(email: params[:email]) #найди пользователя по емэйлу
  	if user && !user.activated? && user.authenticated?(:activation, params[:id]) #если пользователь равен не активированому и токен из бд равны
  	  user.activate # Активирует учетную запись
  	  log_in user #сделай вход пользователя
  	  flash[:success] = "Account activated!" 
      redirect_to user #перенаправь на страницу пользователя
    else #иначе отправь на корневой маршрут
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end 	
  end
end
