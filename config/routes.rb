Rails.application.routes.draw do
  root 'static_pages#home'
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
  resources :microposts,          only: %i[new index create destroy]
  resources :relationships,       only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :testsessions, only: [:create]
  get     '/index', to: 'maps#index'
  get     '/help', to: 'static_pages#help'
  get     'microposts/rank', to: 'microposts#rank'
  get     'microposts/search', to: 'microposts#search'
end
