require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "should redirect edit when not logged in" do #должен перенаправлять редактирование, когда вы не вошли в систему
    get edit_user_path(@user), params: {id: @user} # послать запрос 
    assert_not flash.empty? #не должно быть пустым
    assert_redirected_to login_url #переадресовать на url
  end  

  test "should redirect update when not logged in" do #должен перенаправлять обновление, когда вы не авторизуетесь
    patch user_path(@user), params: {id: @user}, params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end  
end
