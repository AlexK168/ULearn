Rails.application.routes.draw do
  devise_for :users
  root to: 'courses#index'
  resources :courses, only: %i[index show] do
    resources :chapters, only: :index
  end
  resources :chapters, only: :show

  namespace :teacher do
    get 'courses', to: 'courses#index_mine'
    get 'courses/:id', to: 'courses#show_mine'
    resources :courses, only: %i[new edit update create destroy] do
      resources :chapters, shallow: true
    end
  end
end
