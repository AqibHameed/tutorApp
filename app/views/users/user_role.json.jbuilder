if @tutor.present?
  json.extract! @tutor,  :fees, :education, :experience, :availablity
elsif @student.present?
  json.extract! @student,  :price
  if @student.timing.present?
    json.timing @student.timing.localtime.strftime("%I:%M %p")
  else
    json.timing ""
  end
else

end