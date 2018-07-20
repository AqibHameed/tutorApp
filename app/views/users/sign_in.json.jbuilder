json.sid @session.id
json.stoken @session.stoken
json.user do
  json.partial! "users/user", user: @user
end