class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) # email = params{:sessions{email: @ }} найди пользователя с эти емайлом
    if user && user.authenticate(params[:session][:password])  #email && password = true пороль должен пренадлежать к емэйлу ползователя
      log_in user # Осуществить вход пользователя по id (берет id пользователя шифрует)
      redirect_to user #переадресовать на страницу профиля
    else
      flash.now[:danger] = 'Invalid email/password combination' # иначе выводи короковременное сообщение об ошибке
      render 'new'
    end
  end
  
  def destroy
  end  
end
