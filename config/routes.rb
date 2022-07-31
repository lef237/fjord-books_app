Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users do
    resources :follow_relationships, only: [:create, :destroy], module: :users
    member do
      get :followings, :followers
    end
  end
end
