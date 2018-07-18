class TutorController < ApplicationController

	def check_requests
 		current_user = params[:tutor_id]
		@requests = Request.where(tutor_id:current_user, acceptance:false)
		unless @requests.nil?
			render status: :created, template: "requests/index"
		else
			render status: :not_found , json: {errors: "No requests found"}	 	
		end
	end

	def approve_requests
	  current_user = params[:tutor_id]
	  @request = Request.find(params[:request_id])
	  @request.update(acceptance:true)
	  @job = Job.new(subject:@request.subject,tutor_id:current_user)
	  if @job.save
	  	render status: :created, template: "jobs/show"
	  else
	  	render status: :not_found , json: {errors: @job.errors.full_messages}	 
	  end	
	end	


end
