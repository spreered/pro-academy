Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  namespace :admin do
    root to: 'courses#index'
    resources :courses, :categories
  end

  mount API => '/'
end
