module SessionsHelper
  # Осуществляет вход данного пользователя по id.
  def log_in(user)
    session[:user_id] = user.id #session[:user_id] присвает зашифрованное id пользователя ключ user_id значение user.id
  end  

  # Запоминает пользователя в постоянном сеансе.
  def remember(user)
    user.remember #генерирует тоукен и сохроняет в бд его дайджест
    cookies.permanent.signed[:user_id] = user.id #вызывает метод cookies зашефрованную на 20 лет и присваевает user_id  id пользователя
    cookies.permanent[:remember_token] = user.remember_token #затем remember_token присваевает токен пользователя
  end 

  # Возвращает пользователя, соответствующего токену в cookie.
  def current_user
    if (user_id = session[:user_id]) #если id присвоен временному id 
      @current_user ||= User.find_by(id: user_id) #то найди его по временному id и верни временный сеанс
    elsif (user_id = cookies.signed[:user_id]) #если id присвоен постоянный id 
      user = User.find_by(id: user_id) #то присвой постоянный id постоянный сеанс cookies
      if user && user.authenticated?(cookies[:remember_token]) #если токен пользовотеля и токен из бд совподают то 
        log_in user #осущиствить вход пользователя
        @current_user = user # и присвой ему id пользователя
      end
    end    
  end 


  # Возвращает true, если пользователь зарегистрирован, иначе возвращает false.
  def logged_in?
    !current_user.nil? #не должен быть пустым текущий пользователь
  end

  # Закрывает постоянный сеанс.
  def forget(user)
    user.forget #забыть пользователя
    cookies.delete(:user_id) #удаляет id
    cookies.delete(:remember_token) #удаляет токен
  end  

  # Осуществляет выход текущего пользователя.
  def log_out
    forget(current_user) #выход текущего пользователя
    session.delete(:user_id) #удаение id из сессии
    @current_user = nil  #присваение id nil  
  end


end


