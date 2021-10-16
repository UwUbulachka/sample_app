require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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
    follow_redirect! # переадресацию к отображению шаблона 'users/show' после отправки формы
    end
    assert_template 'users/show' # праверка обращения к методу show при удачной регистрации
    assert_not flash.nil? #коротковременное сообщение не должено быть пустым
  end
end
