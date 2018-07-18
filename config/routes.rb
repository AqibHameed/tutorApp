Rails.application.routes.draw do
  # resources :admins, only: [:index,:show]
  get "/admins/pending_requests" ,to: "admins#pending_request"
  put "/admins/assign_requests"  ,to: "admins#assign_request"
  get "/admins/pending_subjects" ,to: "admins#pending_subjects"
  put "/admins/approve_subject"  ,to: "admins#approve_subjects"
  delete "/admins/delete_subject/:subject_id",to: "admins#disapprove_subject"
  resources :subjects, only: [:index,:show]
  post "/students/:id",to: "student#create_request"
  put  "/tutor/request_approve",to: "tutor#approve_requests"
  get  "/tutor/my_requests",to:"tutor#check_requests"
  resources :users
end
