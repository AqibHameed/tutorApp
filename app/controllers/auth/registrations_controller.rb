class Auth::RegistrationsController < ApiControllerController




=begin
 @apiVersion 1.0.0
 @api {post} auth/signup
 @apiName  Sign UP
 @apiGroup Auth
 @apiDescription User Sign UP
 @apiParamExample {json} Request-Example:
  {
  "name":"taha",
  "email":"d@ak.com",
  "username":"taha11",
  "gender": true,
  "password":"Password1",
  "password_confirmation":"Password1"
  }
 @apiSuccessExample {json} SuccessResponse:
   [
     {
        "sid": 1,
        "stoken": "DRZhwFo75xJ8",
        "user": {
        "name": "taha",
        "email": "d@ak.com",
        "username": "taha11",
        "gender": true
        }
      }
   ]
=end

  def create

    #if params[:role].present?
      @user = User.new(user_params)

      if @user.save
          @auth = @user.build_auth(auth_params) #bcz of 1 -to -1 relation we write build_auth

          if @auth.save
            @session = @user.sessions.build

            if @session.save
               #@user.add_role params[:role]
               return render_user_successfully_created
            else
             return render_error_session_not_saved
            end

          else
            @user.destroy
            return render_error_auth_not_saved
          end

      else
        return render_error_user_not_saved
      end
    #else
    #    return render_error_role_not_found
    #end

  end

 def check_username

   if params[:username].present?
     username = User.find_by(username: params[:username])
     if !username.nil?
       return render_username_already_exist
     else
       return render_username_is_available
     end
   else
     return render_username_not_entered
   end
 end



 protected

  #check username
  def render_username_is_available
    render status: :ok ,json: {success: I18n.t('render.errors.registration.username_available')}
  end

  def render_username_already_exist
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.registration.username_already_taken')}
  end

  def render_username_not_entered
    render status: :bad_request, json: {errors: I18n.t('render.errors.registration.username_not_present')}
  end

  def render_user_successfully_created
    render status: :created, template: "users/sign_in"
  end

  #check username end
  def render_error_user_not_saved
    render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
  end

  def render_error_auth_not_saved
    render status: :unprocessable_entity, json: {errors: @auth.errors.full_messages}
  end

  def render_error_session_not_saved
    render status: :unprocessable_entity, json: {errors: @session.errors.full_messages}
  end

  def render_error_role_not_found
    render status: :unprocessable_entity, json: {errors: "Role should not be blank"}
  end



  private
  def user_params
    params.permit(:name, :email, :username, :gender, :about)
  end

  def auth_params
    params.permit(:password, :password_confirmation)
   end
end
