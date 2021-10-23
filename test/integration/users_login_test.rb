require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup #создание пользователя
    @user = users(:michael)
  end
    
  test "login with invalid information" do
    get login_path #открыть страницу входа
    assert_template 'sessions/new' #должен отаброжать страницу верно
    post login_path, params: { session: { email: "", password: "" }} #отправить ошибучную информацию
    assert_template 'sessions/new' #должен отбражаться снова если отправлена ошибочная информация 
    assert_not flash.empty? #сообщение об ошибке не должно быть пустым
    get root_path # перейти на другую странцу
    assert flash.empty? #убедитьсяб что там нет сообщения об ошибке
  end

  test "login with valid information" do
    get login_path #открыть форму входа
    post login_path, params: {session: {email: @user.email, password: 'password'}} #отправить существующий логи и пороль
    assert_redirected_to @user #перенаправить на usera
    follow_redirect! # открывает страницу
    assert_template 'users/show' #должен отображать страницу верно
    assert_select "a[href=?]", login_path, count: 0 # после входа должно быть 0 ссылок на "вход"
    assert_select "a[href=?]", logout_path #должна появиться ссылка для выхода
    assert_select "a[href=?]", user_path(@user) # и профиль
  end  

  test "login with valid information followed by logout" do
    get login_path #открыть форму входа
    post login_path, params: {session: {email: @user.email, password: 'password'}} #отправить существующий логи и пороль
    assert is_logged_in? #должен появиться индификатор
    assert_redirected_to @user #перенаправить на usera
    follow_redirect! # открывает страницу
    assert_template 'users/show' #должен отображать страницу верно
    assert_select "a[href=?]", login_path, count: 0 # после входа должно быть 0 ссылок на "вход"
    assert_select "a[href=?]", logout_path #должна появиться ссылка для выхода
    assert_select "a[href=?]", user_path(@user) # и профиль
    delete logout_path #выйте
    assert_not is_logged_in? # не должно существовать id 
    assert_redirected_to root_path # перенаправить на корневой маршрут
    delete logout_path # Сымитировать щелчок на ссылке для выхода во втором окне
    follow_redirect! # открыть страницу
    assert_select "a[href=?]", login_path # должна появитьс ссылка вход 
    assert_select "a[href=?]", logout_path, count: 0   #должны ичезнуть ссылки выход
    assert_select "a[href=?]", user_path(@user), count: 0 # и профиль
  end 

  test "login with remembering" do
    log_in_as(@user, remember_me: '1') # войти если юзер нажал на флажек
    assert_not_nil cookies['remember_token'] #токен не должен быть пустым
    assert_equal assigns(:user).remember_token, cookies['remember_token'] #токен пользователя должен быть равет токену из бд
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')  #войти если юзер не нажал на флажек
    assert_nil cookies['remember_token'] #токен должен быть пустым
  end

end  
