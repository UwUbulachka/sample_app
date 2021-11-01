require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup 
  @user = users(:michael)
  end

  test "index including pagination" do
    log_in_as(@user) #вход
    get users_path #перейти на список пользователей
    assert_template 'users/index' #страница должна выводиться верно
    assert_select 'div.pagination' # утверждать выбор
    User.paginate(page: 1).each do |user| 
      assert_select 'a[href=?]', user_path(user), text: user.name
    end  
  end
end
