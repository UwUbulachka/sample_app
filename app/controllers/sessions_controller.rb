class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase) # email = params{:sessions{email: @ }} найди пользователя с эти емайлом (true && true == true)
    if @user && @user.authenticate(params[:session][:password])  #email && password = true пороль должен пренадлежать к емэйлу ползователя
      log_in @user # Осуществить вход пользователя по id (берет id пользователя шифрует)
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user) #Запоминает пользователя по id если флажок равен 1 то запоминай пользователя иначе забывай
      redirect_to @user #переадресовать на страницу профиля
    else
      flash.now[:danger] = 'Invalid email/password combination' # иначе выводи короковременное сообщение об ошибке
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in? #выход только если пользователь зарегестрирован 
    redirect_to root_url #перенапровление на корневой маршрут
  end  
end
