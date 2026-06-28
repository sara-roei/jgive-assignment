Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :campaigns, only: [:show] do
    resources :donations, only: [:create]
  end

  root to: redirect("/campaigns/1")
end
