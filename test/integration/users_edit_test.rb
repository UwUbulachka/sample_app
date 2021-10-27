require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do #неудачное редактирование
    get edit_user_path(@user) #посетить страницу пользователя для обновления
    assert_template 'users/edit' #должена открываться вернная страница 
    patch user_path(@user), params: {user: { name: '', # отправить невернную информацию методом patch 
                                            email: 'foo@invalid',
                                            password: 'foo',
                                            password_confirmation: 'bar' }}
    assert_template 'users/edit' #должена открываться вернная страница 
  end

  test "successful edit" do
    get edit_user_path(@user) #посетить страницу пользователя для обновления
    assert_template 'users/edit'#должена открываться вернная страница 
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {user: { name: name, # отправить вернную информацию методом patch 
                                             email: email,
                                             password: "",
                                             password_confirmation: "" }}
    assert_not flash.empty? #коротковременное сообщение не должно быть пустым
    assert_redirected_to @user #перенаправить на пользователя 
    @user.reload #убидить, что пользователь оновлен успешно
    assert_equal @user.name, name # имя из бд должно быть равно новому имени
    assert_equal @user.email, email # email из бд должно быть равно новому email                                          
  end
end
