class Auth::RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      @auth = @user.build_auth(auth_params) #bcz of 1 -to -1 relation we write build_auth
      if @auth.save
        @session = @user.sessions.build
        if @session.save
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



  private
  def user_params
    params.permit(:name, :email, :username, :gender, :about)
  end

  def auth_params
    params.permit(:password, :password_confirmation)
   end
end
