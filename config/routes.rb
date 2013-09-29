Webdevleague::Application.routes.draw do
  #get 'browser' => 'browser#index'
  devise_for :users
  get '/home' => 'home#index'

  resources :diagrams
  resources :divisions, only: %w(index show)
  resources :users, only: %w(index show)
  resources :questions

  root :to => 'home#index'
end
