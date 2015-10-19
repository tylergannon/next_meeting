Rails.application.routes.draw do

  resources :meetings do
    get :search, on: :collection
  end
  resources :meeting_groups
  resources :meeting_locations
  root to: 'pages#index'
end
