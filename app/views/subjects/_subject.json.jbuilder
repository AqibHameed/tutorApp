json.extract! subject, :id, :name, :code,:approved, :created_at, :updated_at
json.url subject_url(subject, format: :json)
