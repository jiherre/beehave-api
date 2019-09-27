Rails.application.routes.draw do
  post '/token', to: 'tokens#create'

  resources :features, only: [:index, :show, :create, :new]
end
