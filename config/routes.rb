Rails.application.routes.draw do
  resources :examples
  resources :people, only: [:index]
  get '/people/me' => 'people#show'
  post '/auth/saml/callback' => 'auth#saml_callback'
end
