class TutorController < ApiControllerController
	before_action :authenticate_user_from_id_and_token!, only: [:index]

=begin
 @apiVersion 1.0.0
 @api {get} tutor
 @apiName list of tutors
 @apiGroup Tutor
 @apiDescription list of all tutors
@apiParamExample {json} Request-Example:
{
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
    {
    "tutors": [
        {
					"id": 1,
					"education": "BSCS",
					"experience": "2 years",
					"availablity": "yes",
					"timing": "",
					"name": "talha",
					"gender": true,
					"phone": null,
					"martial_status": null,
					"age": null,
					"subjects": [
							{
									"id": 1,
									"name": "PHP"
							}
					 ]
         }
      ]
    }
=end

	def index
		  @users = User.all.where(user_status: 1)
			if @users.present?
         @tutors = @users.map{|user| user.tutor}.compact
			else
				 @tutors = []
			end
	end
=begin
 @apiVersion 1.0.0
 @api {get} tutor/id
 @apiName tutor profile
 @apiGroup Tutor
 @apiDescription tutor profile
@apiParamExample {json} Request-Example:
{
  "id": "1"
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
   {
    "tutor": {
        "id": 1,
        "education": "BSCS",
        "experience": "2 years",
        "availablity": "yes",
        "user_id": 2,
        "created_at": "2018-09-25T13:11:54.037Z",
        "updated_at": "2018-09-25T14:06:43.915Z",
        "fees": "5000",
        "timing": null
     }
   }
=end
	def show
		  @tutor = Tutor.find_by(id: params[:id])
		  if @tutor.present?
				render status: :ok , json: {tutor: @tutor}
			else
				render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
			end
	end

=begin
 @apiVersion 1.0.0
 @api {get} tutor/my_requests
 @apiName tutor check request
 @apiGroup Request
 @apiDescription Tutor checks his lists of request
 @apiSuccessExample {json} SuccessResponse:
   [
	{
		"status": "sent to a suitable teacher",
		"tutor": "The tutor has not accepted the request",
		"studentname": "TAHA",
		"studentusername": "taha10",
		"requestID": 14,
		"subjectName": "Java",
		"tutorName": "taha",
		"tutorEducation": "abc",
		"tutorExperience": "1-2 years"
	}
   ]
  @apiHeaderExample {json} Header-Example:
    {
        "sid": "2"
        "stoken":"wNJBYeyqHkbU"
    }  
=end
	def check_requests
		@requests = Request.where(tutor_id:@current_user.tutor, acceptance:false)
		unless @requests.nil?
			render status: :created, template: "requests/index"
		else
			render status: :not_found , json: {errors: "No requests found"}	 	
		end
	end

=begin
 @apiVersion 1.0.0
 @api {put} tutor/request_approve
 @apiName tutor approves student request
 @apiGroup Request
 @apiDescription Tutor acepts the jobs assigned by the admin
  @apiParamExample {json} Request-Example:
	{
	"request_id":14
	}
 @apiSuccessExample {json} SuccessResponse:
   [
	{
		"status": "sent to a suitable teacher",
		"tutor": "The tutor has not accepted the request",
		"studentname": "TAHA",
		"studentusername": "taha10",
		"requestID": 14,
		"subjectName": "Java",
		"tutorName": "taha",
		"tutorEducation": "abc",
		"tutorExperience": "1-2 years"
	}
   ]
  @apiHeaderExample {json} Header-Example:
    {
        "sid": "2"
        "stoken":"wNJBYeyqHkbU"
    }  
=end


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
