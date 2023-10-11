Rails.application.routes.draw do
  get 'teams/index'
  get 'competitions/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "standalonepages#homepage"
  resources :leagues, only: [:index]
  resources :seasons, only: [:index]
  resources :competitions, only: [:index]
  resources :teams, only: [:index]

end
