Rails.application.routes.draw do
  post '/token', to: 'tokens#create'

  resources :features, only: [:index, :show, :create, :update, :destroy]

  post '/features/:id/push', to: 'features#push_to_git'
end
