Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "standalonepages#homepage"
  resources :leagues, only: [:index,:new,:create,:show,:edit,:update,:destroy]
  resources :seasons, only: [:index,:new,:create,:show,:edit,:update,:destroy]
  resources :competitions, only: [:index,:new,:create,:show,:edit,:update,:destroy]
  resources :teams, only: [:index,:new,:create,:show,:edit,:update,:destroy]

end
