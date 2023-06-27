Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/mypage', to: 'users#mypage', as: 'mypage'
  get '/items/new', to: 'items#new', as: 'new_item'
  resources :items, except: [:new]
end