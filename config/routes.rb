Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  resources :clients, only: [:new, :create] do
    namespace :survey do
      resources :session_rating_scales
    end
  end
end
