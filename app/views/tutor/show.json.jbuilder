json.extract! @tutor,:education, :experience, :fees
json.extract! @tutor.user, :name, :gender, :year_of_completion, :institution, :age
json.name @tutor.user.name
if @tutor.timing.present?
  json.timing @tutor.timing.localtime.strftime("%I:%M %p")
else
  json.timing ""
end
json.subjects @tutor.subjects.each do |subject|
  json.id subject.id
  json.name subject.name
end
