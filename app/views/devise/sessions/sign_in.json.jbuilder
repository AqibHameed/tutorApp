json.uid @user.id
json.utoken @user.authentication_token
json.user do
  json.partial! "devise/sessions/user", user: @user
end