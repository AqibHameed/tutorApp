if @request.acceptance == true
   json.message "Your request is accepted"
elsif @request.acceptance == false
   json.message "Request has been sent."
end