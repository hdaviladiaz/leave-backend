Rails.application.routes.draw do
  get '/leave_requests/me' => 'leave_requests#me'
  get '/leave_requests/me/approve' => 'leave_requests#approve'
  resources :leave_requests
  resources :examples
  resources :people, only: [:index]
  resources :calendars
  get '/people/me' => 'people#show'
  post '/auth/saml/callback' => 'auth#saml_callback'
  
end
