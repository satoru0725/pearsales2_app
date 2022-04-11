Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  root to: "products#index"
  resources :users, only: [:index, :show, :edit, :update ] do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  
  resources :customers, only: [:show, :edit, :update ]

  get '/my_cart' => 'carts#my_cart'
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'
  
end
