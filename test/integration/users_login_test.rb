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
end