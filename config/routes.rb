Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :posts do
    member do
      get :toggle_like
    end
    collection do
      get :my_comments
    end
  end
  resources :comments


end
