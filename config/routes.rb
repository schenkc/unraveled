Unraveled::Application.routes.draw do
  get 'users/activate' => 'users#activate_user'
  root to: 'sessions#new'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
