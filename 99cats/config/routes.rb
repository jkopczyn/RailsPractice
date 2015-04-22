Rails.application.routes.draw do

  resources :cats
  resources :cat_rental_requests
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  post 'cat_rental_requests/:id/approve', to: "cat_rental_requests#approve", as: "approve_request"
  post 'cat_rental_requests/:id/deny', to: "cat_rental_requests#deny", as: "deny_request"

end
