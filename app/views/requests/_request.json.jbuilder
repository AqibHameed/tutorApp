if request.status == false
  json.status "Your request is under observation by the admin"
else
  json.status "Your request is sent to a suitable teacher"
  if request.acceptance == false
  json.tutor "The tutor has not accepted the request"
  else
  json.tutor request.tutor
  end
end  	 


json.extract! request, :id , :student, :subject

unless request.tutor.nil? #should be removed later
  json.tutor request.tutor
end

 	