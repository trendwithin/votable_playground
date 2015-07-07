Rails.application.routes.draw do

  resources :articles do
    member do
      put "like", to: "articles#upvote"
      put "dislike", to: "articles#downvote"
    end
  end

  root 'home#index'

  devise_for :users
end
