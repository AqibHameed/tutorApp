json.partial! "users/user", user: @user
if @tutor.present?
  json.extract! @tutor,  :education, :experience
  if @tutor.timing.present?
    json.timing @tutor.timing.localtime.strftime("%I:%M %p")
  else
    json.timing ""
  end
elsif @student.present?
  json.extract! @student,  :price
  if @student.timing.present?
    json.timing @student.timing.localtime.strftime("%I:%M %p")
  else
    json.timing ""
  end
else

end