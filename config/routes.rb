Rails.application.routes.draw do
  root to: "root#index"

  devise_for :users

  scope :api, defaults: { format: :json } do
    scope :v1 do
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
