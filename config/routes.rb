Rails.application.routes.draw do
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new' #Страница представления нового сеанса (вход)
  post 'login'   => 'sessions#create' #Создание нового сеанса (вход)
  delete 'logout'  => 'sessions#destroy' #Удаление сеанса (выход)
  resources :users do 
    member do 
      get :following, :followers # users/1/following, /users/1/followers
    end  
  end
  resources :users #rest все
  resources :account_activations, only: [:edit] #rest только для edit 
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end 
