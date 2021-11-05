require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
   ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do #неверная регистрационная информация
    get signup_path #получение страницы
    assert_no_difference 'User.count' do #(утверждать отсутствие разницы)(пользователь не должен создаться при неверной форме)сравнение значения User.count до и после выполнения блока
      post users_path, params: {user: { name: "", # отправить форму пользователя
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end  
    assert_template 'users/new' # праверка повторного обращения к методу new при ошибочной регистрации
    assert_select 'div#error_explanation'  # проверка вывода ошибок из стилей scss
    assert_select 'div.field_with_errors'
     
  end  

  test "valid signup information" do #верная регистрационная информация
    get signup_path
    assert_difference 'User.count', 1 do #(утверждать разницу) пользователь должен создоваться (1 не обязтельно)
      post users_path, params: {user: { name: "Example User", 
                                    email: "user@example.com",
                                    password: "password",
                                    password_confirmation: "password" }}

    end
    assert_equal 1, ActionMailer::Base.deliveries.size #должно быть доставлено точно одно письмо
    user = assigns(:user) #получить доступ к переменной экземпляра
    assert_not user.activated? #не должен быть активированым
    # Попытаться выполнить вход до активации.
    log_in_as(user)
    assert_not is_logged_in? #нелья войти
    # Недопустимый токен активации
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Допустимый токен, неверный адрес электронной почты
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Допустимый токен
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated? #пользователь должен перезагрузиться и стать активированным
    follow_redirect! #проверить перенапровление 
    assert_template 'users/show' # праверка обращения к методу show при удачной регистрации
    assert is_logged_in? #проверяет вход пользователя 
    assert_not flash.nil? #коротковременное сообщение не должено быть пустым
  end
end
