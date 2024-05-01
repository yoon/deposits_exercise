Rails.application.routes.draw do
  resources :tradelines, only: [:index, :show] do
    resources :deposits, only: [:index, :show, :create]
  end
end
