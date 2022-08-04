Rails.application.routes.draw do
  resources :reports do
    resources :comments, only: [:create, :destroy], module: :reports
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
  # resources :comments, only: [:create, :destroy]
end

# TODO：resources :reports の位置を後で確認する
