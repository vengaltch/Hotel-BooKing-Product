Rails.application.routes.draw do
  get 'api_dock/index'
  get 'home/index'
  post 'home/search'
  get 'search/check_avaiblity'
  get 'search/get_room_types'
  resources :bookings, only: [:index, :create]
  devise_for :users
  devise_scope :user do
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
