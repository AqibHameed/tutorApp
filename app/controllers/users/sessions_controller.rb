# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
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
  # def destroy
  #   super
  # end

  protected

  def invalid_login_attempt
    render json: {success: false, message: "Invalid Username or password"}, status: 401
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
