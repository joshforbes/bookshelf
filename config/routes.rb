Rails.application.routes.draw do
  scope module: :books do
    resources :books
  end
end
