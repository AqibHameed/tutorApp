class StudentController < ApplicationController
	before_action :authenticate_user


=begin
 @apiVersion 1.0.0
 @api {post} students/create_request
 @apiName create request
 @apiGroup Request
 @apiDescription Student request for a particular subject
 @apiParamExample {json} Request-Example:
  {
  "subject_id":4
  }
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "status": "under observation by the admin",
    "studentname": "TAHA",
    "studentusername": "taha10",
    "requestID": 14,
    "subjectName": "Java"
  }
   ]
     @apiHeaderExample {json} Header-Example:
    {
        "sid": "1"
        "stoken":"wNJBYeyqHkbU"
    }  
=end


  def create_request
		@student = @current_user.student
  		if params[:subject_id].present?
  			@request = Request.new(student:@student,subject_id:params[:subject_id].to_i)
  			if @request.save
  			render status: :created, template: "requests/show"
  			else
  			render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}	
  			end
  		else
  		render status: :not_found , json: {errors: I18n.t('students.error.Subject_ID_not_found')}	
  		end
  end


=begin
 @apiVersion 1.0.0
 @api {get} students/pending_requests
 @apiName check request
 @apiGroup Request
 @apiDescription Student check his request status
 @apiParamExample {json} Request-Example:
  {
  "subject_id":4
  }
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "status": "under observation by the admin",
    "studentname": "TAHA",
    "studentusername": "taha10",
    "requestID": 14,
    "subjectName": "Java"
  }
   ]
       @apiHeaderExample {json} Header-Example:
    {
        "sid": "1"
        "stoken":"wNJBYeyqHkbU"
    }   
=end

  def check_request
    @student = @current_user.student
      @requests = Request.where(student:@student)
      unless @requests.nil?
        render status: :ok ,template: "requests/index"
      end 
  end  
	

end
