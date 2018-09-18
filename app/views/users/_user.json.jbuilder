json.extract! user,  :id, :name, :email, :username, :gender
#json.role @role.name
if user.user_type == 1
   json.role "teacher"
elsif user.user_type == 0
   json.role "student"
else
end

unless user.tutor.nil?
  json.tutor user.tutor
  json.subjects user.tutor.subjects
end

unless user.student.nil?
  json.student user.student
end