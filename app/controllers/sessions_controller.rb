class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase) # email = params{:sessions{email: @ }} найди пользователя с эти емайлом (true && true == true)
    if @user && @user.authenticate(params[:session][:password])  #email && password = true пороль должен пренадлежать к емэйлу ползователя
      if @user.activated? #если пользователь активирован
        log_in @user # Осуществить вход пользователя по id (берет id пользователя шифрует)
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user) #Запоминает пользователя по id если флажок равен 1 то запоминай пользователя иначе забывай
        redirect_back_or @user # Перенаправить по сохраненному адресу или на страницу по умолчанию.
      else
        message = "Account not activated. " #если пользователь не активирован
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end 
    else #если пользователь не зарегестрирован
      flash.now[:danger] = 'Invalid email/password combination' 
      render 'new'
    end  
  end

  def destroy
    log_out if logged_in? #выход только если пользователь зарегестрирован 
    redirect_to root_url #перенапровление на корневой маршрут
  end  
end
