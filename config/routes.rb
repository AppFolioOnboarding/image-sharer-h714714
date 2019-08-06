Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'images#index'

  resources :images, only: [:new, :create, :show, :index, :destroy] # rubocop:disable Style/SymbolArray
end
