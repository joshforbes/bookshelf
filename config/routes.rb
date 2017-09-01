Rails.application.routes.draw do
  scope module: :books do
    resources :books, only: [:create] do
      resources :tags, only: [:create, :destroy]
    end
  end
end
