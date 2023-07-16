Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/mypage', to: 'users#mypage', as: 'mypage'
  get '/items/new', to: 'items#new', as: 'new_item'
  get '/items', to: 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  devise_scope :user do
    authenticated :user do
      root 'items#new', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end