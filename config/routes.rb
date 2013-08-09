Webdevleague::Application.routes.draw do
  devise_for :users
  get '/home' => 'home#index'

  resources :users

  root :to => 'home#index'
end
