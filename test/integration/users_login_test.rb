require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path #открыть страницу входа
    assert_template 'sessions/new' #должен отаброжать страницу верно
    post login_path, params: { session: { email: "", password: "" }} #отправить ошибучную информацию
    assert_template 'sessions/new' #должен отбражаться снова если отправлена ошибочная информация 
    assert_not flash.empty? #сообщение об ошибке не должно быть пустым
    get root_path # перейти на другую странцу
    assert flash.empty? #убедитьсяб что там нет сообщения об ошибке
  end  
end
