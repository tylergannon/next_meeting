Rails.application.routes.draw do

  resources :meetings
  resources :meeting_groups
  resources :meeting_locations
  root to: 'pages#index'
end
