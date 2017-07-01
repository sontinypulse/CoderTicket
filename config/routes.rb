Rails.application.routes.draw do
  get 'users/new'

  get 'upcoming' => 'events#index'
  root 'events#index'

  get 'search' => 'search#search'

  resources :users

  resources :events do
    resources :tickets
  end
end
