Rails.application.routes.draw do

  resources :articles

  root 'home#index'

  devise_for :users
end
