if @request.acceptance == true
   json.status "Your request is accepted"
elsif @request.acceptance == false
   json.status "under observation by the admin"
end