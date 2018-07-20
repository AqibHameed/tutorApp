if request.acceptance == true
json.status "Your request is accepted"
else	
	if request.status == false
	  json.status "under observation by the admin"
	else
	  json.status "sent to a suitable teacher"
	  if request.acceptance == false
	  json.tutor "The tutor has not accepted the request"
	  else
	  json.tutor request.tutor
	  end
	end
end	

json.studentname request.student.user.name
json.studentusername request.student.user.username
json.requestID request.id
json.subjectName request.subject.name
# json.extract! request, :subject


unless request.tutor.nil? #should be removed later

  json.tutorName request.tutor.user.name
  json.tutorEducation request.tutor.education
  json.tutorExperience request.tutor.experience
end

 	