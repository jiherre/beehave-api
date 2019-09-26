Rails.application.routes.draw do
  post '/token', to: 'tokens#create'
  resources :projects, only: [:index]
end
