require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end  

  test "profile display" do 
    get user_path(@user) #зайти на страниу пользователя
    assert_template 'users/show' #убедиться, что страница открывается
    assert_select 'title', full_title(@user.name) #проверить заголовок польозвателя
    assert_select 'h1', text: @user.name #в h1 должен быть тест с имени польозвателя
    assert_select 'h1>img.gravatar' #проверить gravatar
    assert_match @user.microposts.count.to_s, response.body #подтвердить соотвествие  кол во микросообщений в теле сообщения
    assert_select 'div.pagination' #должны быть министраницы 
    @user.microposts.paginate(page: 1).each do |micropost| #микро посты разбитые на одной страницы у каждого поста
      assert_match micropost.content, response.body #должен прсутсвовать атрибут content
    end
  end  
end
