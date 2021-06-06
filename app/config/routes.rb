Rails.application.routes.draw do
  resources :sample, only: [:index]

  root "sample#index"
end
