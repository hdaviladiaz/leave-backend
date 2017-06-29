Rails.application.routes.draw do
  get '/leave_requests/me' => 'leave_requests#me'
  get '/leave_requests/me/approve' => 'leave_requests#approve'
  get '/leave_requests/approved' => 'leave_requests#approved'
  get '/leave_requests/rejected' => 'leave_requests#rejected'
  get '/leave_requests/taken_leaves' => 'leave_requests#taken_leaves'
  get '/leave_requests/me/available_leave_days' => 'leave_requests#available_leave_days'
  get '/leave_requests/all_taken' => 'leave_requests#all_taken'
  get '/leave_requests/all_approved' => 'leave_requests#all_approved'
  get '/people/me' => 'people#show'
  get '/people/except_me' => 'people#index_except_me'
  post '/auth/saml/callback' => 'auth#saml_callback'

  resources :leave_requests
  resources :examples
  resources :people, only: [:index]
  resources :calendars
  
end
