Rails.application.routes.draw do
  scope module: :auth do
    resource :sessions, only: [:create, :destroy]
  end
  scope module: :books do
    resources :books, only: [:create] do
      resources :tags, only: [:create, :destroy]
      resources :owners, only: [:create]
      delete :owners, to: 'owners#destroy', as: 'owner'
    end
  end
  scope module: :rentals do
    resources :rentals, only: [:create, :destroy]
  end
end
