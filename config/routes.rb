Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:show]
  resources :reviews, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get 'search', to: 'reviews#search'
  get "tag_search", to: "reviews#tag_search"
  resources :tags, only: [:index, :show] do
    
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
