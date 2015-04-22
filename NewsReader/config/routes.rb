NewsReader::Application.routes.draw do
  namespace :api do
    resources :users, only: [:create, :new]
    resource :session, only: [:create, :new, :destroy]
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index]
    end
  end

  root to: "static_pages#index"
end
