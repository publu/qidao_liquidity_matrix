Rails.application.routes.draw do

  root "tokens#index"

  devise_for :users

  resources :networks do
    collection do
      post :import
    end
  end

  resources :tokens do
    collection do
      post :import
    end
  end

  resources :minters do
    collection do
      post :import
    end
  end

  get "dashboard" => "dashboards#index"

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
