class AdminsController < ApiControllerController

  def first
    render status: :ok , template: "changes/root"
   end

=begin
 @apiVersion 1.0.0
 @api {get} admins/pending_subjects
 @apiName pending_subjects
 @apiGroup Subject
 @apiDescription Show subjects created by the teacher
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "id": 11,
    "name": "abc",
    "code": null,
    "approved": false,
    "created_at": "2018-07-18T12:16:46.464Z",
    "updated_at": "2018-07-18T12:16:46.464Z",
    "url": "http://localhost:3000/subjects/11.json"
  },
   ]
=end

  def pending_subjects
    @subjects = Subject.where(approved:false)
    if !@subjects.nil?
    render status: :ok, template: "subjects/index"
    else
      render status: :bad_request, json: {errors: "Their is no unapproved subjects for now"}
    end
  end


=begin
 @apiVersion 1.0.0
 @api {put} admins/assign_requests
 @apiName approve_subjects
 @apiGroup Subject
 @apiDescription approve subjects created by the teacher
 @apiParamExample {json} Request-Example:
  {
  "subject_id":11,
  "approved":"true"
  }
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "id": 11,
    "name": "abc",
    "code": null,
    "approved": false,
    "created_at": "2018-07-18T12:16:46.464Z",
    "updated_at": "2018-07-18T12:16:46.464Z",
    "url": "http://localhost:3000/subjects/11.json"
  }
   ]
=end

  def approve_subjects
    if params[:subject_id].present?
      @subject = Subject.find(params[:subject_id])
      if !@subject.nil?
        @subject.update(approved:true)
        render status: :ok, template: "subjects/show"
      else
      render status: :bad_request, json: {errors: "subject_id is Invalid"}  
      end  
    else
      render status: :not_found, json: {errors: "subject_id not found"}
    end  

  end

=begin
 @apiVersion 1.0.0
 @api {delete} admins/delete_subject/id
 @apiName Deleting_subjects
 @apiGroup Subject
 @apiDescription delete subjects created by the teacher
 @apiSuccessExample {json} SuccessResponse:
   [
    "no content"
   ]
=end




  def disapprove_subject
     @subject = Subject.where(id:params[:subject_id],approved:"false")
     @subject.destroy_all
  end  

=begin
 @apiVersion 1.0.0
 @api {get} admins/pending_requests
 @apiName pending_request
 @apiGroup Request
 @apiDescription Show all request sent by students
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "status": "under observation by the admin",
    "studentname": "TAHA",
    "studentusername": "taha10",
    "requestID": 12,
    "subjectName": "Java"
  }
   ]
=end


  def pending_request
    @requests = Request.where(status:false).order(created_at: :desc)
    #byebug
    render status: :ok, template: "requests/index"
  end

=begin
 @apiVersion 1.0.0
 @api {put} admins/assign_requests
 @apiName assign_request
 @apiGroup Request
 @apiDescription Show all request sent by students
 @apiParamExample {json} Request-Example:
    {
      "tutor_id":21,
      "request_id":14
    }
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "status": "under observation by the admin",
    "studentname": "TAHA",
    "studentusername": "taha10",
    "requestID": 12,
    "subjectName": "Java"
  }
   ]
=end


  def assign_request
    if params[:tutor_id].present? && params[:request_id].present?
      @request = Request.find(params[:request_id])
      @tutor   = Tutor.find_by(id:params[:tutor_id])
      if @request.status == false
        @request.status = true
         if !@tutor.nil?
        @request.tutor_id = params[:tutor_id]
        @request.update(tutor_id: params[:tutor_id])
        render status: :ok, template: "requests/show"
        else
          render status: :not_found , json: {errors: "Invalid Tutor Id"}
         end
      else
        render status: :bad_request, json: {errors: "request already assigned"}    
      end  
    else
      render status: :not_found , json: {errors: "tutor_id or request_id is not set"} 
    end
  end

end
