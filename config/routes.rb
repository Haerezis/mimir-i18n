Rails.application.routes.draw do
  root to: "root#index"

  devise_for :users

  namespace :api, defaults: { format: :json }, except: [:new, :edit] do
    namespace :v1 do
      resource :current_user, only: [:show, :update], as: :current_user, controller: 'current_user'
      resources :projects do
        scope module: :project do
          resources :translations
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
