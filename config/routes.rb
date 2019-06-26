Rails.application.routes.draw do
  get 'top/timeline'
  root 'pages#index'
  get 'pages/show'
  get 'pages/timeline_page'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get 'anthem_view/anthem_view'
  get '/pages/killthread'
end
