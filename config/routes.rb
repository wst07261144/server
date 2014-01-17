Server::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end

  root to: 'static_pages#home'

  match '/help'    => 'static_pages#help',    via: 'get'
  match '/about'=> 'static_pages#about',   via: 'get'
  match '/contact'=> 'static_pages#contact', via: 'get'
  match '/signup'=> 'users#new', via: 'get'
  match '/signin'=> 'sessions#new',         via: 'get'
  match '/signout'=> 'sessions#destroy',     via: 'delete'
end
