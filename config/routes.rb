Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'clients#new'

  resources :clients, only: [:new, :create] do
    namespace :survey do
      resources :session_rating_scales
    end
  end

  # Area displaying each therapists performance
  resources :therapists, only: [:index, :show] do
    resources :clients, only: :show
  end
end
