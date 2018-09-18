class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user ,only: [:show, :updated]

=begin
 @apiVersion 1.0.0
 @api {get} users
 @apiName List of all Users
 @apiGroup Users
 @apiDescription List of all users
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "id": 1,
    "name": "TAHA Updated",
    "info": null,
    "role": 0,
    "created_at": "2018-07-17T10:46:04.834Z",
    "updated_at": "2018-07-17T10:47:14.749Z",
    "url": "http://localhost:3000/users/1.json"
  }
   ]
=end

  def index
    @users = User.all
  end

=begin
 @apiVersion 1.0.0
 @api {get} users/id
 @apiName user profile
 @apiGroup Users
 @apiDescription user profile
@apiParamExample {json} Request-Example:
{
  "sid":"1",
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "sid": 7,
    "stoken": "FJd2JQGc9GsP",
    "user": {
        "name": "talha",
        "email": "talha@gmail.com",
        "username": "talha11",
        "gender": true,
        "role": "teacher"
    }
}
   ]
=end



  def show

    if @user.user_type == 1
        @tutor = @user.tutor
    elsif @user.user_type == 0
        @student = @user.student
    end

  end

=begin
 @apiVersion 1.0.0
 @api {put} users/role
 @apiName select role
 @apiGroup Users
 @apiDescription Set Tutor
 @apiParamExample {json} Request-Example:
  {
   "user_type":1,
  "education":"abc",
  "experience":"1-2 years",
  "availablity":"YES",
  "subject_ids":[1,2,3],
  "subjects":["FROMsss","INSOMIAsss"]
  }
 @apiSuccessExample {json} SuccessResponse:
   [
      {
  "name": "taha",
  "email": "d@ak.com",
  "username": "taha11",
  "gender": true,
  "tutor": {
    "id": 23,
    "education": "abc",
    "experience": "1-2 years",
    "availablity": "YES",
    "user_id": 42,
    "created_at": "2018-07-20T14:19:12.746Z",
    "updated_at": "2018-07-20T14:19:12.746Z"
  },
  "subjects": [
    {
      "id": 1,
      "name": "Mathematics",
      "code": null,
      "created_at": "2018-07-17T13:26:27.723Z",
      "updated_at": "2018-07-17T13:26:27.723Z",
      "approved": true
    }
    ]
    }
   ]
       @apiHeaderExample {json} Header-Example:
 {
  "sid": "2"
  "stoken":"wNJBYeyqHkbU"
} 
=end


=begin
 @apiVersion 1.0.0
 @api {put} users/role
 @apiName select role
 @apiGroup Users
 @apiDescription Set Student
 @apiParamExample {json} Request-Example:
  {
 "user_type":0,
  "name":"TAHA",
  "info":"This is an info",
  "price":3,
  "datetime": "2018-07-17 17:14:22"
  }
 @apiSuccessExample {json} SuccessResponse:
   [
      {
  "name": "TAHA",
  "email": "d@aj.com",
  "username": "taha10",
  "gender": true,
  "student": {
    "id": 13,
    "price": 3,
    "timing": null,
    "user_id": 41,
    "created_at": "2018-07-20T13:47:22.873Z",
    "updated_at": "2018-07-20T13:47:22.873Z"
  }
}
   ]
@apiHeaderExample {json} Header-Example:
{   
  "sid": "2"
  "stoken":"wNJBYeyqHkbU"

}
=end




  def updated
    @user = @current_user
    if @user.update(user_params)
      if params[:user_type].present?
        if params[:user_type] == 1
          @tutor = @user.build_tutor(tutor_params)
           unless params[:subjects].nil?
              @tutor = @user.build_tutor(tutor_params)
              @subject_from_user = params[:subjects]
              @subject_from_user.each do |s|
              @subject = Subject.new(name:s,approved:false)
                if @subject.save
                  @tutor.subjects << @subject
                end 
              end 
           end  
            if @tutor.save
              render status: :created, template: "users/show"
            else
               render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
            end
        elsif params[:user_type] == 0
            @student = @user.build_student(student_params)
              if @student.save
                render status: :created, template: "users/show"
              else
                render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
              end  
        elsif params[:user_type] == 2
            @student = @user.build_student(student_params)
              if @student.save
              else
                render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
              end
               @tutor = @user.build_tutor(tutor_params)
                unless params[:subjects].nil?
                  @tutor = @user.build_tutor(tutor_params)
                  @subject_from_user = params[:subjects]
                  @subject_from_user.each do |s|
                  @subject = Subject.new(name:s,approved:false)
                    if @subject.save
                      @tutor.subjects << @subject
                    else  
                      # render status: :unprocessable_entity, json: {errors: @subject.errors.full_messages}
                    end 
                  end 
                end  
              if @tutor.save
                render status: :created, template: "users/show"
              else
                 render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
              end
        end
      else
      render :show, status: :ok, location: @user  
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def student_params
      params.permit(:price,:timing)
    end  

    def tutor_params
      params.permit(:education, :experience, :availablity ,subject_ids:[])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :info, :user_type)
    end
end
