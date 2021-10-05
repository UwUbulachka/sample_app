require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
   test "layouts links" do
     get root_path #выполнить переход по корневому маршруту
     assert_template 'static_pages/home' #убедиться, что возвращается правильная страница
     assert_select "a[href=?]", root_path, count: 2 #проверить корректность ссылок на страницы Home, Help, About и Contact
     assert_select "a[href=?]", help_path
     assert_select "a[href=?]", about_path
     assert_select "a[href=?]", contact_path
     get signup_path #выполнить переход в sign up
     assert_select "title", full_title('Sign up') #проверь заголовок 
   end
end
