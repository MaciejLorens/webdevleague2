Webdevleague::Application.routes.draw do
  #get 'browser' => 'browser#index'
  devise_for :users
  get '/home' => 'home#index'

  resources :users, only: %w(index show)
  resources :divisions, only: %w(index show)

  root :to => 'home#index'
end
