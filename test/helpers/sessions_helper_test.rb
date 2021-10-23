require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @user = users(:michael)
    remember(@user) # Запоминает пользователя в постоянном сеансе.
  end 

  test "current_user returns right user when session is nil" do #current_user возвращает правого пользователя, когда сессия равна нулю
    assert_equal @user, current_user # user должен быть равен соответствующему токену в cookie.
    assert is_logged_in? #пользователь должен быть зарегестрирован
  end
  
  test "current_user returns nil when remember digest is wrong" do #current_user возвращает ноль, если помнит, что дайджест неверен
    @user.update_attribute(:remember_digest, User.digest(User.new_token)) #обновляет запомненный дайджест и и обновляет токен (хеширует новый запоненный токен)
    assert_nil current_user #должен возврощать nil соответствующему токену в cookie.
  end     
end 

