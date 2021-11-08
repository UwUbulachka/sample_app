require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)    
  end

  test "should be valid" do #должно быть действительным
    assert @micropost.valid?
  end  

  test "user id should be present" do #должен присутствовать идентификатор пользователя
    @micropost.user_id = nil #если идентификатор пользователя равен nil
    assert_not @micropost.valid? #то micropost не должен быть валидным
  end  

    test "content should be present" do #контент должен присутствовать
      @micropost.content = " "
      assert_not @micropost.valid?
  end

    test "content should be at most 140 characters" do #содержание должно быть не более 140 символов
    @micropost.content = "a" * 141
    assert_not @micropost.valid? 
  end
end
