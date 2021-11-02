require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
    
  test "should redirect edit when not logged in" do #должен перенаправлять редактирование, когда вы не вошли в систему
    get edit_user_path(@user), params: {id: @user} #попытка открытьпользователя не войдя в систему
    assert_not flash.empty? #не должно быть пустым
    assert_redirected_to login_url #переадресовать на url
  end  

  test "should redirect update when not logged in" do #должен перенаправлять обновление, когда вы не авторизуетесь
    patch user_path(@user), params: {id: @user}, params: { user: { name: @user.name, email: @user.email } } #попытка изменения пользователя, когда вы не вошли в систему
    assert_not flash.empty?
    assert_redirected_to login_url
  end  

  test "should redirect edit when logged in as wrong user" do #должен перенаправлять редактирование при входе в систему как неправильный пользователь
    log_in_as(@other_user)#вход пользователя 
    get edit_user_path(@user), params: {id: @user} #попытка открыть другого пользователя
    assert flash.empty? #не должно быть пустым
    assert_redirected_to root_url #переадресовать на url
  end 

  test "should redirect update when logged in as wrong user" do #должен перенаправлять обновление при входе в систему как неправильное использование
    log_in_as(@other_user) #вход пользователя 
    patch user_path(@user), params: {id: @user}, params: { user: { name: @user.name, email: @user.email } } #попытка изменения другого пользователя
    assert flash.empty?
    assert_redirected_to root_url
  end 

  test "should redirect destroy when not logged in" do #должен перенаправить destroy, когда вы не вошли в систему
    assert_no_difference 'User.count' do #не должно быть разницы в кол ве пользователей
      delete user_url(@user), params: {id: @user}  #попытка удалить пользователя не войдя в систему
    end #не должно быть разницы в кол ве пользователей
    assert_redirected_to login_url  #переноправить на страницу входа
  end 

  test "should redirect destroy when logged in as a non-admin" do #должен перенаправить destroy при входе в систему как неадминистратор
    log_in_as(@other_user) #войти под другим пользователем
    assert_no_difference 'User.count' do #не должно быть разницы в кол ве пользователей
      delete user_url(@user), params: {id: @user} #попытаться удалить польозвателя, без администрации
    end  #не должно быть разницы в кол ве пользователей
    assert_redirected_to root_url #переноправить на корнвой мартшрут
  end 
end
