json.extract! user, :id, :name, :info, :role, :created_at, :updated_at

unless user.tutor.nil?
 json.tutor user.tutor
 json.subjects user.tutor.subjects
end

unless user.student.nil?
 json.student user.student
end


json.url user_url(user, format: :json)
