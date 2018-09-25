# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
=begin
 @apiVersion 1.0.0
 @api {post} users/sign_in
 @apiName User Sign IN
 @apiGroup Users
 @apiDescription Sign In for user
  @apiParamExample {json} Request-Example:
{
  "username":"a@a",
  "password":"Password1"
}
 @apiSuccessExample {json} SuccessResponse:
   [
    {
    "sid": 2,
    "stoken": "omMr8pRhH1RCpD1YDZfF",
    "user": {
        "name": "amjad",
        "email": "amjad@gmail.com",
        "username": "amjad11",
        "gender": true,
        "user_status": 0,
        "role": "teacher",
        "tutor": {
            "id": 4,
            "education": null,
            "experience": null,
            "availablity": null,
            "user_id": 2,
            "created_at": "2018-09-24T16:03:54.231Z",
            "updated_at": "2018-09-24T16:03:54.231Z",
            "fees": null
          },
        "subjects": []
      }
    }
}
   ]
=end
  def create

    @user = User.find_by_username(params[:username])
    #@user = User.find_for_database_authentication(username: params[:username])

    if @user
      @user.authentication_token =  Devise.friendly_token
      if @user.save
          if @user.valid_password?(params[:password])
            sign_in("user", @user)
            render status: :created, template: "devise/sessions/sign_in"
            #render json: {success: true, authentication_token: resource.authentication_token, email: resource.email, id: resource.id}
            return
          end
      else
          return invalid_login_attempt
      end
    end

    invalid_login_attempt
  end

  # DELETE /resource/sign_out
=begin
    @apiVersion 1.0.0
    @api {delete} users/sign_out
    @apiName Sign Out
    @apiGroup Users
    @apiDescription User Sign Out
    @apiHeaderExample {json} Header-Example:
        {
          "stoken":"wNJBYeyqHkbU"
        }
    @apiSuccessExample {json} SuccessResponse:
     [
      {
          "success": true,
          "message": "Successfully signed out"
      }
     ]
=end
  def destroy
    @user = User.find_by_authentication_token(params[:stoken])

    if @user.present?
      @user.update(authentication_token: nil)
      sign_out @user
      render json: {success: true, message: 'Successfully signed out'}
    else
       render status: :not_found , json: {errors: "User not exist"}
    end

  end

  protected

  def invalid_login_attempt
    render json: {success: false, message: "Invalid Username or password"}, status: 401
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
