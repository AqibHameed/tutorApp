json.tutors @tutors.each do |tutor|
    json.id tutor.id
    json.education tutor.education
    json.experience tutor.experience
    json.availablity tutor.availablity
end