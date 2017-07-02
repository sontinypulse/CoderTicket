Rails.application.routes.draw do
  get 'users/new'

  get 'upcoming' => 'events#index'
  root 'events#index'

  get 'search' => 'search#search'
  get 'users/check_email' => 'users#check_email'
  get 'users/sign_in' => 'users#sign_in'
  post 'users/authenticate' => 'users#authenticate'
  post 'tickets/buy' => 'tickets#buy'
  delete 'log_out' => 'users#log_out'
  resources :users

  resources :events do
    resources :tickets
  end
end
