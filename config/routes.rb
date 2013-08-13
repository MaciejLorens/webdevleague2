Webdevleague::Application.routes.draw do
  devise_for :users
  get '/home' => 'home#index'

  resources :users, only: %w(index show)
  resources :divisions, only: %w(index show)

  root :to => 'home#index'
end
