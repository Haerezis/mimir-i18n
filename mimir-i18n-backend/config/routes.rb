Rails.application.routes.draw do
  root to: "root#index"

  scope module: :api, path: "api" do
    scope module: :v1, path: "v1" do
      devise_for :users, controllers: {sessions: 'api/v1/sessions'}
      devise_scope :user do
        get 'users/current', to: 'sessions#show'
      end
    end
  end

  namespace :api, defaults: { format: :json }, except: [:new, :edit] do
    namespace :v1 do

      resource :current_user, only: [:show, :update], as: :current_user, controller: 'current_user'

      resources :projects do
        member do
          patch :locales, action: :update_locales
        end

        scope module: :project do
          resources :access_keys, only: [:index, :show, :create,:update, :destroy]

          resources :releases, only: [:index, :show, :create, :destroy] do
            member do
              get :export
            end
          end

          resources :translations do
            collection do
              post :do_many
              patch :update, action: :update_many
            end
          end
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
