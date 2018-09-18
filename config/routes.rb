Rails.application.routes.draw do

root "admins#first"
  namespace :auth do
    get "/check_username",to: "registrations#check_username"
    post "/signup",to: "registrations#create"
    post "/signin",to: "sessions#create"
    delete "/signout",to: "sessions#signout"
    get "/verify",to: "verifications#validate"
    get "/request_new_verification_pin" ,to: "verifications#new_pin"
    put "/change_password",to: "passwords#reset"
    post '/reset_password', to: 'passwords#forgot'
    put '/reset_password', to: 'verifications#reset'
    get '/validate',to: "token_validations#validate"
    get '/verify_email',to: 'verifications#confirm' ,as:"verification"
  end

  get "/admins/pending_requests" ,to: "admins#pending_request"
  put "/admins/assign_requests"  ,to: "admins#assign_request"
  get "/admins/pending_subjects" ,to: "admins#pending_subjects"
  put "/admins/approve_subject"  ,to: "admins#approve_subjects"
  delete "/admins/delete_subject/:subject_id",to: "admins#disapprove_subject"
  resources :subjects, only: [:index,:show] do
    collection do
      get 'sub_search'
    end
  end
  post "/students/create_request",to: "student#create_request"
  get  "/students/pending_requests",to:"student#check_request"
  get "/tutor", to: "tutor#index"
  put  "/tutor/request_approve",to: "tutor#approve_requests"
  get  "/tutor/my_requests",to:"tutor#check_requests"
  resources :users , except: [:create,:destroy,:update]
  put  "/users/role", to:"users#updated"
end
