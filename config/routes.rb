Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/contact', to: 'pages#contact'
  resources :toys, only: [:index, :new, :create, :show, :edit, :update] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, except: [:new, :create] do
    member do
      patch :update_status
    end
  end

  resources :user, only: [:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
