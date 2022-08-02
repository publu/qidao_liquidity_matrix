Rails.application.routes.draw do
  devise_for :users
  root "tokens#index"
  resources :networks do
    collection do
      post :import
    end
  end
  resources :tokens
  get "dashboard" => "dashboards#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
