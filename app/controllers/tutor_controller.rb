class TutorController < ApplicationController
	before_action :authenticate_user

	def check_requests
		@requests = Request.where(tutor_id:@current_user.tutor, acceptance:false)
		unless @requests.nil?
			render status: :created, template: "requests/index"
		else
			render status: :not_found , json: {errors: "No requests found"}	 	
		end
	end

	def approve_requests
	  @request = Request.find(params[:request_id])
		if @current_user.tutor == @request.tutor
	  @request.update(acceptance:true)
	  @job = Job.new(subject:@request.subject,tutor:@current_user.tutor,student:@request.student)
	  if @job.save
	  	render status: :created, template: "jobs/show"
	  else
	  	render status: :not_found , json: {errors: @job.errors.full_messages}	 
		end
		else
			render status: :unauthorized , json: {errors: "You are not authorized for this request"}
		end
	end	


end
