class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update] #перед редоктированием пользователь должен подтвердть вход
  before_action :correct_user, only: [:edit, :update] #перед редоктированием пользователь должен подтвердить права пользователя.
  
  def show
    @user = User.find(params[:id])
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #Вход пользователя после регистрации
      flash[:success] = "Welcome to the Sample App!" #создания кратковременного сообщения
      redirect_to @user #переадресации на страницу профиля вновь созданного пользователя
      # Обработать успешное сохранение.
    else
    render 'new'  
    end
  end 

  def edit
    @user = User.find(params[:id])
  end 

  def update
     @user = User.find(params[:id]) #найди пользователя по id в бд
    if @user.update_attributes(user_params) #если пользователь обнавил аттрибуты
       flash[:success] = "Profile updated" #создания кратковременного сообщения
       redirect_to @user #переадрисация на обновленного пользователя
    else
      render 'edit'
    end  

  end

  private

  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end  

  # Подтверждает вход пользователя.
  def logged_in_user
    unless logged_in? #пока пользователь не войдет 
      flash[:danger] = "Please log in." 
      redirect_to login_url #перенаправляй на страницу регистрации
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #перенаправляй на другую страницу пока пользователь не будет равен текущему пользователю
    end
end
