Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pets#index"
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :pets do
    collection do
      get 'search'
    end
  end
end
