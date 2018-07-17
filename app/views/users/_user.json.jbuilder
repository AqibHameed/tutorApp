json.extract! user, :id, :name, :info, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
