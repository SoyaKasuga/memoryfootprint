Rails.application.routes.draw do
  root'static_pages#home'
  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,          only: [:new, :index, :create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  get     '/help', to: 'static_pages#help'
  
end
