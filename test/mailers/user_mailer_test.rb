require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael) 
    user.activation_token = User.new_token #новый токен
    mail = UserMailer.account_activation(user) #присвой mailу почту usera и subject
    assert_equal "Account activation",    mail.subject #должен проверить наличее короткого описания у email
    assert_equal [user.email],            mail.to #проверка кому
    assert_equal ["noreply@example.com"], mail.from #от кого
    assert_match user.name,               mail.body.encoded #утверждать соответсвие имя в email теле сообщения, должно быть закодированно
    assert_match user.activation_token,   mail.body.encoded #токен активаци
    assert_match CGI::escape(user.email), mail.body.encoded #экранный адрес электронной почты
  end

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset",        mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end  
end
