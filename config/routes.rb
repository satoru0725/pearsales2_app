Rails.application.routes.draw do
  devise_for :customers
  devise_for :users
  root to: "products#index"
end
