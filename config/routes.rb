Rails.application.routes.draw do
  root to: "root#index"

  devise_for :users

  scope :api, defaults: { format: :json }, except: [:new, :edit] do
    scope :v1 do
      resource :current_user, except: [:destroy], as: :current_user, controller: 'api/v1/current_user'
      resources :users
      resources :projects do
        scope module: :project do
          resources :users
          resources :translation_keys
          resources :translations
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
