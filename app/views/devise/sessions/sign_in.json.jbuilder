json.sid @user.id
json.stoken @user.authentication_token
json.user do
  json.partial! "devise/sessions/user", user: @user
end