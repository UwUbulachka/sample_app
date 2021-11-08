class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #перед редоктированием пользователь должен подтвердть вход
  before_action :correct_user, only: [:edit, :update] #перед редоктированием пользователь должен подтвердить права пользователя.
  before_action :admin_user, only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end
 
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activate_email #отправь пользователю сообщение сейчас
      flash[:info] = "Please check your email to activate your account."#создания кратковременного сообщения
      redirect_to root_url 
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end 
    
  private

  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end  

  # Подтверждает вход пользователя.
  def logged_in_user
    unless logged_in? #пока пользователь не войдет 
      store_location #запомини url
      flash[:danger] = "Please log in." 
      redirect_to login_url #перенаправляй на страницу регистрации
    end
  end

  # Подтверждает права пользователя.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #перенаправляй на другую страницу пока пользователь не будет равен текущему пользователю
    end

  # Подтверждает наличие административных привилегий
  def admin_user
    redirect_to(root_url) unless current_user.admin? # перенаправля пользователья на корневой маршрут пока текущий пользователь не будет администратором    
  end  
end
