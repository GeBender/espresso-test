Rails.application.routes.draw do
  root 'application#index'

  get :password, to: 'users#password'
  post :password, to: 'users#update_password'
  get :mfa, to: 'users#mfa'
  get :cancel_mfa, to: 'users#cancel_mfa'
  post :mfa, to: 'users#update_mfa'

  resources :users, only: [] do
    post :generate_qr_code, on: :member
  end

  devise_for :users, controllers: {
    passwords: 'passwords'
  }
end
