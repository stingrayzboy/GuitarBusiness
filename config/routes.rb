Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/checkout', to: "home#checkout", as:"checkout"
  post 'home/cart/:product',to: "home#cart",as:"add_to_cart"
  get 'home/pay',to:'home#pay',as:"confirmed_order"
  get 'home/reset',to:'home#reset',as:"reset_order"
  get 'home/orders',to:'home#orders',as:'my_orders'
  get 'home/bills/:id',to:'home#bills',as:'view_bill'
  get 'orders',to:'home#all_orders',as:'all_orders' 
  get 'show',to:'home#show',as:'show_product'
  get 'home/search',to:'home#search',as:'search_product'
  patch 'updatecount',to:'guitars#count_update',as:'count_update'
  patch 'updatecountaccessories',to:'accessories#count_update',as:'count_update_accessory'
  devise_for :users
  resources :accessories
  resources :guitars
  resources :images
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
