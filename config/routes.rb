Webdevleague::Application.routes.draw do
  devise_for :users
  get 'home/index'

  resources
  root :to => 'home#index'
end
