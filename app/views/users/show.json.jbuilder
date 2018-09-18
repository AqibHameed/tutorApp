json.partial! "users/user", user: @current_user
if @tutor.present?
  json.extract! @tutor,  :education, :experience, :availablity
elsif @student.present?
  json.extract! @student,  :price, :timing
else

end