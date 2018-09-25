# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end
=begin
 @apiVersion 1.0.0
 @api {post} users
 @apiName  Sign UP
 @apiGroup Users
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
      "sid": 2,
      "stoken": "zpNyG5A_WMzQCLx6pDBx",
      "user": {
          "name": "amjad",
          "email": "amjad@gmail.com",
          "username": "amjad11",
          "gender": true,
          "role": "student"
      }
    }
   ]
=end

  # POST /resource
  def create
    @user = User.new(user_params)
    @user.authentication_token = Devise.friendly_token

    if @user.save
      render status: :created, template: "devise/sessions/sign_in"
      #render json: user.as_json(authentication_token: user.authentication_token, email: user.email), status: 201
    else
      render json: resource.errors, status: 422
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    params.require(:registration).permit(:name, :email, :username, :gender, :password, :password_confirmation)
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
