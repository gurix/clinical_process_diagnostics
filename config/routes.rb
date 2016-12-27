Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'clients#new'

  resources :clients, only: [:new, :create] do
    namespace :survey do
      resources :session_rating_scales
    end
  end

  # Area displaying each therapists performance
  resource :reset_therapist_token, only: [:new, :create]
  resources :therapists, only: [:index, :show], param: :token do
    resources :clients, only: :show, param: :token
  end
end
