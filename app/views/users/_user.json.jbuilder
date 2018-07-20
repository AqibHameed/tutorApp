json.extract! user,  :name, :email, :username, :gender

unless user.tutor.nil?
  json.tutor user.tutor
  json.subjects user.tutor.subjects
end

unless user.student.nil?
  json.student user.student
end