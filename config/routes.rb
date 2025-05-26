Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  root "short_urls#new"

  # Rutas para acortar URLs
  resources :short_urls, only: [ :new, :create ], path: "urls"

  # Rutas para acceder a las URLs cortas
  get "/:short_code", to: "redirections#show", as: :short_url
  get "/:short_code/stats", to: "short_urls#stats", as: :short_url_stats
end
