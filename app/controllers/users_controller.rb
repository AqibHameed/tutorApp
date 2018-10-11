class UsersController < ApiControllerController
  before_action :set_user, only: [:show]
  before_action :authenticate_user_from_id_and_token!

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
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "id": 3,
    "name": "aqib",
    "email": "wasim@gmail.com",
    "username": "taha11",
    "gender": true,
    "phone": "123456",
    "address": "Johr toen lahore",
    "degree": null,
    "year_of_completion": "2015",
    "institution": "UOL",
    "majors": "programing",
    "expectation": "abc",
    "martial_status": 0,
    "age": "25 year",
    "role": "student",
    "tutor": {
        "id": 2,
        "education": "Mphil",
        "experience": "1-2 years",
        "availablity": "yes",
        "user_id": 3,
        "created_at": "2018-09-28T11:35:33.729Z",
        "updated_at": "2018-09-28T14:40:10.895Z",
        "fees": "5000",
        "timing": "2018-09-27T23:00:00.000Z"
    },
    "subjects": []
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
   "stoken":"wNJBYeyqHkbU"
   "tutor_id":1,
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
        "fees": "3000",
        "education": "PHD",
        "experience": "1-2 years",
        "availablity": "YES"
     }
   ]
=end


=begin
 @apiVersion 1.0.0
 @api {put} users/role
 @apiName select role
 @apiGroup Users
 @apiDescription Set Student
 @apiParamExample {json} Request-Example:
  {
 "stoken":"wNJBYeyqHkbU"
 "student_id":1,
 "user_type":0,
  "price":3,
  "timing": "2018-07-17 17:14:22"
  }
 @apiSuccessExample {json} SuccessResponse:
   [
      {
       "price": 600,
       "timing": "2018-09-24T19:39:03.000Z"
      }
   ]
=end




  def updated

      params[:timing] = params[:timing].present? ? params[:timing].to_time : params[:timing]

      if params[:user_type].present?

        if params[:user_type].to_i == 1
          @tutor = Tutor.find_by_id(params[:tutor_id])

          if @tutor.present?

            if @tutor.update(tutor_params)

               unless params[:subjects].nil?
                  @subject_from_user = params[:subjects]

                  @subject_from_user.each do |s|

                      sub = Subject.find_by_name(s)

                      if sub.present?
                           @tutor.subjects << @subject
                      else
                        @subject = Subject.new(name:s, approved:false)

                        if @subject.save
                          @tutor.subjects << @subject
                        end

                      end

                  end

               end

               render status: :ok , json: {message: "attributes update sucesfully"}
            else
              render json: @tutor.errors, status: :unprocessable_entity
            end

          else
            render status: :not_found , json: {message: "tutor id not found"}
          end

        elsif params[:user_type].to_i == 0
          @student = Student.find_by_id(params[:student_id])

          if @student.present?

            if @student.update(student_params)
              render status: :created, template: "users/user_role"
            else
              render json: @student.errors, status: :unprocessable_entity
            end

          else
            render status: :not_found , json: {message: "student id not found"}
          end
        else
          render status: :not_found , json: {message: "user type not match"}
        end

      else
         render status: :not_found , json: {message: "user type not found"}
      end
  end

=begin
 @apiVersion 1.0.0
 @api {get} users/user_role_update
 @apiName  role update
 @apiGroup Users
 @apiDescription user role update
 @apiParamExample {json} Request-Example:
  {
   "stoken":"wNJBYeyqHkbU"
   "user_type":0,
  }
 @apiSuccessExample {json} SuccessResponse:
   [
      {
        "message": "Tutor Request successfully sent to admin"
      }
  ]
=end

  def user_role_update

    #if @user.waiting_status == 0

      if params[:user_type].present?

         if @user.update(user_params)

            if params[:user_type].to_i == 1
                @tutor = @user.build_tutor

                if @tutor.save
                  @user.update(user_status: 1)
                  render status: :ok , json: {message: "Become a tutor successfully"}
                  # @request = Request.new(tutor: @tutor)
                  #
                  # if @request.save
                  #
                  #   @user.update(waiting_status: 1)
                  #   render status: :ok , json: {message: "Tutor Request successfully sent to admin"}
                  # else
                  #
                  #   render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}
                  # end

                else

                  render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
                end

            elsif  params[:user_type].to_i == 0
              @student = @user.build_student

              if @student.save

                @user.update(user_status: 1)
                render status: :ok , json: {message: "Become a student successfully"}
                  #@request = Request.new(student: @student)

                  # if @request.save
                  #     @user.update(waiting_status: 1)
                  #     render status: :ok , json: {message: "Student Request successfully sent to admin"}
                  # else
                  #     render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}
                  # end

              else
                  render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
              end

            else
              render status: :unprocessable_entity, json: {errors: "user type not match"}
            end

          else
              render json: @user.errors, status: :unprocessable_entity
          end

      else
          render status: :not_found , json: {message: "user type not found"}
      end
    # else
    #
    #     render status: :not_found , json: {message: "Request already sent"}
    # end

  end
=begin
  @apiVersion 1.0.0
  @api {put} users/profile_update
  @apiName select user profile update
  @apiGroup Users
  @apiDescription Edit Profile
  @apiParamExample {json} Request-Example:
      {
        "stoken":"wNJBYeyqHkbU"
        "student_id":1,
         "tutor_id":1
       "user":{
              "name": "aqib",
              "gender": true,
              "phone": "123456",
              "address": "Johr toen lahore",
              "year_of_completion": "2015",
              "majors": "programing",
              "institution": "UOL",
              "martial_status": 0,
              "age": "25 year",
              "expectation": "abc",
              "tutor_attributes":{
                "id": "2",
                 "education": "Mphil",
                 "experience": "1-2 years",
                 "fees": "5000",
                 "timing":"4:00 AM"
               }
        }
     }
  @apiSuccessExample {json} SuccessResponse:
      [
          {
            "user":{
              "name": "aqib",
              "gender": true,
              "phone": "123456",
              "address": "Johr toen lahore",
              "year_of_completion": "2015",
              "majors": "programing",
              "institution": "UOL",
              "martial_status": 0,
              "age": "25 year",
              "expectation": "abc",
              "tutor_attributes":{
                "id": "2",
                 "education": "Mphil",
                 "experience": "1-2 years",
                 "fees": "5000"
                 }
              }
          }
      ]
=end

  def profile_update

    if params[:tutor_id].present?

       @tutor = Tutor.find_by(id: params[:tutor_id])

       if @tutor.present?

         if params[:user][:tutor_attributes][:timing].present?

            @tutor.update(timing: params[:user][:tutor_attributes][:timing].to_time)
         end

         if @user.update(user_tutor_params)
             render status: :ok, template: "users/profile_update"
         else
            render status: :unprocessable_entity, json: {errors: "tutor params not update"}
         end
       else
          render status: :unprocessable_entity, json: {errors: "tutor  not exist"}
       end

    elsif params[:student_id].present?
      @student = Student.find_by(id: params[:student_id])

      if @student.present?

        if params[:user][:student_attributes][:timing].present?
          @student.update(timing: params[:user][:student_attributes][:timing].to_time)
        end

        if @user.update(user_student_params)
           render status: :ok, template: "users/profile_update"
        else
           render status: :unprocessable_entity, json: {errors: "student params not update"}
        end

      else
        render status: :unprocessable_entity, json: {errors: "student  not exist"}
      end

    else
        render status: :not_found, json: {errors: "Id not found"}
    end

  end



  private

    def student_params
      params.permit(:price,:timing)
    end  

    def tutor_params
      params.permit(:experience, :timing)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      #params.permit(:name, :info, :user_type)
      params.permit(:user_type)
    end

    def user_tutor_params

      params.require(:user).permit(:name, :gender, :phone, :address, :degree, :year_of_completion, :majors, :institution, :martial_status, :age, :expectation,tutor_attributes: [:id, :education, :experience, :fees ])
    end

    def user_student_params
      params.require(:user).permit(:name, :gender, :phone, :address, :degree, :year_of_completion, :majors, :institution, :martial_status, :age,  student_attributes: [:id, :price])
    end
end
