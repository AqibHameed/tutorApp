json.extract! tutors, :id, :education, :experience,:availablity, :created_at, :updated_at
json.url tutor_url(tutors, format: :json)
