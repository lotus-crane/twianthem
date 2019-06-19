Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/show'
  get 'pages/timeline_page'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
end
