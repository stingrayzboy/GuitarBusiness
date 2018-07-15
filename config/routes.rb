Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/checkout', to: "home#checkout", as:"checkout"
  devise_for :users
  resources :accessories
  resources :guitars
  resources :images
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
