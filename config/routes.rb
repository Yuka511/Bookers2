Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  root to: "homes#top"
  get "home/about", to: "homes#about"
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
