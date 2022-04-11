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
  
  
end
