Rails.application.routes.draw do
  resources :leave_requests
  resources :examples
  resources :people, only: [:index]
  resources :calendars
  get '/people/me' => 'people#show'
  post '/auth/saml/callback' => 'auth#saml_callback'
end
