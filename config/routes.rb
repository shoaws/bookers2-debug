Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get 'homes/top'
  root to: "homes#top"
  get "home/about"=>"homes#about",　as: 'about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'followings/:id' => 'relationships#followings', as: 'followings'
  get 'followers:id' => 'relationships#followers', as: 'followers'

  get "search" => "searches#search"

  resources :rooms, only: [:show] do
    resources :chats, only: [:create, :destroy]
  end
  
  resources :groups, except: [:destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end