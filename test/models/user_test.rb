require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") #создание допустимго пользоватля
  end  

  test "should be valid" do #должно быть действительным
    assert @user.valid? #пользователь должен быть валидным(действительным)
  end
  
  test "name should be present" do #имя должно присутствовать 
    @user.name = " "  #пустой юзер
    assert_not @user.valid? #не должно быть валидным(действительным)
  end  

  test "email should be present" do #емеил должен присутсвовать
    @user.email = " " #пустой юзер
    assert_not @user.valid? #не должно быть валидным
  end

  test "name should not be too long" do  #электронная почта не должна быть слишком длинной
    @user.name = "a" * 51 #умножения строки
    assert_not @user.valid?
  end

  test "email should not be too long" do #электронная почта не должна быть слишком длинной
    @user.email = "a" * 244 + "@example.com" #умножения строки
    assert_not @user.valid?
  end 

  test "email validation should accept valid addresses" do #проверка электронной почты должна принимать действительные адреса
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
                      first.last@foo.jp alice+bob@baz.cn] #разбивание допустимых адрессов на массивы
    valid_addresses.each do |valid_address| #пройтись по каждому адрессу
      @user.email = valid_address ## user с допустимым адрессом
      assert @user.valid?, "#{valid_address.inspect} should be valid" #(вывод емайла) должен быть действительным
    end                  
  end

  test "email validation should reject invalid addresses" do #проверка электронной почты должна отклонять недопустимые адреса
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com] #разбивание не допустимых адрессов на массивы
    invalid_addresses.each do |invalid_address| #пройтись по каждому адрессу
      @user.email = invalid_address # user с не допустимым адрессом
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end 

  test "email addresses should be unique" do #адреса электронной почты должны быть уникальными
    duplicate_user = @user.dup #создает пользователя с такими же атрибутами 
    duplicate_user.email = @user.email.upcase #email = EMAIL
    @user.save #сохранить в бд 
    assert_not duplicate_user.valid? #не должно быть дубликатов даже в верхнемо регистре
  end

  test "email addresses should be saved as lower-case" do #адреса электронной почты должны быть сохранены в нижнем регистре
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email #email = Foo@ExAMPle.CoM
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email #утверждать равенство  между foo@exemple.com (Foo@ExAMPle.CoM) и email из базы данных
  end  

  test "password should have a minimum length" do #пароль должен иметь минимальную длину
    @user.password = @user.password_confirmation = "a" * 5 #если пороль меньше пяти символов то пользователь должен быть не валидным
    assert_not @user.valid?
  end 

  test "authenticated? should return false for a user with nil digest" do #аутентифицирован? должен возвращать false для пользователя с нулевым дайджестом
    assert_not @user.authenticated?(:remember, '') #должен быть не аутенфицирован
  end 
end
