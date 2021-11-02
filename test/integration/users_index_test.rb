require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup 
  @admin = users(:michael)
  @non_admin = users(:archer)
  end

  test "index including pagination" do #индекс, включая нумерацию страниц
    log_in_as(@admin) #вход
    get users_path #перейти на список пользователей
    assert_template 'users/index' #страница должна выводиться верно
    assert_select 'div.pagination' # утверждать тег div.pagination
    first_page_of_users = User.paginate(page: 1) # первая страница для пользователей
    first_page_of_users.each do |user|  # каждая страница для позователей должна выглядить так
      assert_select 'a[href=?]', user_path(user), text: user.name #ссылка на польозвателя
      unless user == @admin #пока пользователь не будет админом
        assert_select 'a[href=?]', user_path(user), text: 'delete', method: :delete # для админа должна существовать ссылка на удалиение страницы
      end
    end
    assert_difference 'User.count', -1 do #должен иметь разницу на одного пользователя меньше
      delete user_path(@non_admin) #удаление не админа 
    end#должен иметь разницу на одного пользователя меньше  
  end

  test "index as non-admin" do #индексировать как неадминистративный
    log_in_as(@non_admin) # вход не админа
    get users_path # перенаправилть на страницу всех пользователей
    assert_select 'a', text: 'delete', count: 0 #должно существовать 0 ссылок удаления
  end  
end
