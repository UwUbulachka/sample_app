module SessionsHelper
  # Осуществляет вход данного пользователя по id.
  def log_in(user)
    session[:user_id] = user.id #session[:user_id] присвает зашифрованное id пользователя ключ user_id значение user.id
  end  

  # Возвращает текущего вошедшего пользователя (если есть).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # Ищит текущего пользователя в бд по id    
  end

  # Возвращает true, если пользователь зарегистрирован, иначе возвращает false.
  def logged_in?
    !current_user.nil? #не должен быть пустым текущий пользователь
  end  
end
