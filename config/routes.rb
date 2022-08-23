Rails.application.routes.draw do
  scope "(:locale)", locale: /en|es|fr/ do
    root "tokens#index"

    resources :networks, path: "chains" do
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

    get "/dashboard", to: "dashboards#index"
    devise_for :users, controllers: { registrations: "registrations" }
    get "/sitemap", to: "tokens#sitemap"

    match "/404", to: "errors#not_found", via: :all
    match "/500", to: "errors#internal_server_error", via: :all
  end

end
