if @tutor.present?
  json.extract! @tutor,  :fees, :education, :experience, :availablity
elsif @student.present?
  json.extract! @student,  :price, :timing
else

end