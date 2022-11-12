Rails.application.routes.draw do
  devise_for :users, path: 'devise'
  root to: 'homes#top'
  resources :post_images, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show,:edit,:update,:index, :destroy]
end
