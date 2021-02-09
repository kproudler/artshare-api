Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :destroy, :index, :show, :update] do
    resources :artworks, only: [:index]
  end

  resources :artworks

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:index, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]

end
