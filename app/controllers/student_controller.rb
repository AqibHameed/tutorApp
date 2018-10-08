class StudentController < ApiControllerController
	before_action :authenticate_user_from_id_and_token!


=begin
 @apiVersion 1.0.0
 @api {post} students/create_request
 @apiName create request
 @apiGroup Request
 @apiDescription Student request for a particular subject
 @apiParamExample {json} Request-Example:
  {
  "stoken":"wNJBYeyqHkbU"
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
=end


  def create_request

		@student = @user.student
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
 @api {get} students/student_hire_a_teacher
 @apiName hire a tutor
 @apiGroup Request
 @apiDescription Student request for a particular tutor
 @apiParamExample {json} Request-Example:
 {
  "stoken":"wNJBYeyqHkbU"
	"tutor_id":1
 }
 @apiSuccessExample {json} SuccessResponse:
 [
	{
   "status": "under observation by the admin"
  }
 ]
=end

	def student_hire_a_teacher

		@student = @user.student
    @tutor = Tutor.find_by_id(params[:tutor_id])

		if @tutor.present?
			request = Request.where(student: @student, tutor: @tutor)

			if request.present?
				 render status: :found, json: {message: "Request sent already."}
			else
				@request = Request.new(student: @student, tutor_id: params[:tutor_id].to_i)

				if @request.save
					render status: :created, template: "requests/hire_a_teacher"
				else
					render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}
				end

			end

		else
			 render status: :not_found , json: {errors: 'tutor not exist'}
		end

	end

	def list_of_assign_persons

		if params[:student_id].present?
			 @student = Student.find_by(id: params[:student_id])

			 if @student.present?
				  @tutors = @student.tutors
					if @tutors.present?
						render status: :ok ,template: "requests/list_of_assign_persons"
					else
						render status: :ok ,json: {tutors: @tutors}
					end

			 else
				 render status: :not_found , json: {message: "student not found"}
			 end

		elsif params[:tutor_id].present?
			@tutor = Tutor.find_by(id: params[:tutor_id])

			if @tutor.present?
				@students = @tutor.students
				if @students.present?
					render status: :ok ,template: "requests/list_of_assign_persons"
				else
					render status: :ok ,json: {students: @students}
				end
				
			else
				render status: :not_found , json: {message: "tutor not found"}
			end

		else
			  render status: :not_found , json: {message: "student or tutor id must exist"}
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
  "stoken":"wNJBYeyqHkbU"
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
=end

  def check_request
    @student = @user.student
      @requests = Request.where(student:@student).where.not(subject: [nil, ""])
      unless @requests.empty?
        render status: :ok ,template: "requests/index"
      end 
  end  
	

end
