Rails.application.routes.draw do
  resources :subjects, only: [:index,:show]
  post "/students/:id",to: "student#create_request"
  put  "/tutor/request_approve",to: "tutor#approve"
  resources :users
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
