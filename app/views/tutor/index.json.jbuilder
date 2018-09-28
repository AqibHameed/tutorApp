json.tutors @tutors.each do |tutor|
  json.id tutor.id
  json.education tutor.education
  json.experience tutor.experience
  json.availablity tutor.availablity
  if tutor.timing.present?
    json.timing tutor.timing.strftime("%I:%M %p")
  else
    json.timing ""
  end
  json.name tutor.user.name
  json.gender tutor.user.gender
  json.phone tutor.user.phone
  json.martial_status tutor.user.martial_status
  json.age tutor.user.age

  json.subjects tutor.subjects.each do |subject|
      json.id subject.id
      json.name subject.name
  end
end

