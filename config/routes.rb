Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :destroy, :index, :show, :update]

  resources :artworks

  resources :artwork_shares

end
