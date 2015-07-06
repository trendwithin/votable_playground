Rails.application.routes.draw do

  get 'articles/index'

  root 'home#index'

  devise_for :users
end
