Rails.application.routes.draw do
	resources :charges
  resources :orders
  resources :products
  devise_for :users
  root 'products#index'
    # automaticary looking for the root checkout
    post '/checkout' => 'paypal#checkout'
    get '/execute' =>  'paypal#execute'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
