Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  patch 'users_otp/enable'
  get 'users_otp/disable'
  devise_for :users, controllers: {
     sessions: "sessions"
  }



  root to: 'home#index'
end
