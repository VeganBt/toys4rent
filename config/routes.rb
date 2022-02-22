Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :toys, only: [:index, :new, :create] do
    resources :bookings, only: [:new, :create]
  end

  resources :booking, except: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
