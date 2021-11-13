require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
  end 

  test "should redirect create when not logged in" do #должен перенаправить создание, когда вы не вошли в систему
    assert_no_difference 'Micropost.count' do 
      post microposts_url(@micropost), params: { micropost: { content: "Lorem ipsum "} }
    end 
    assert_redirected_to login_url
  end 
  
  test "should redirect destroy when not logged in" do #должен перенаправить уничтожение, когда вы не авторизуетесь
    assert_no_difference 'Micropost.count' do
      delete micropost_url(@micropost), params: {id: @micropost}
    end
    assert_redirected_to login_url  
  end

  test "should redirect destroy for wrong micropost" do  #должен перенаправить уничтожение для неправильного микросообщения
    log_in_as(users(:michael)) #вход
    micropost = microposts(:ants) #пост другого пользователя
    assert_no_difference 'Micropost.count' do 
      delete micropost_url(micropost), params: {id: micropost} #поптыка удалить пост который не пренодлежит пользователю
    end 
    assert_redirected_to root_url 
  end 
end
