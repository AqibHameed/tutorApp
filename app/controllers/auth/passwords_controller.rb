class Auth::PasswordsController < ApplicationController
  before_action :authenticate_user, only: [:reset]

  def reset
    if params[:old_password].present? and params[:password].present? and params[:password_confirmation].present?
      if @current_user.auth.authenticate(params[:old_password].to_s)
        if @current_user.auth.update(reset_params)
          return render_password_change_successfull
        else
          return render_password_change_unsuccessfull
        end
      else
        return render_incorrect_password
      end
    else
      return render_incorrect_number_of_parameters
    end
  end

  def forgot
   if params[:email].present?
     @user = User.find_by(email: params[:email])
     if !@user.nil?
       @verification = @user.verifications.build(verification_type: VERIFICATION_TYPE_RESET)
       if @verification.save
         return render_successfully_created_new_validation
       else
         return render_unable_to_create_new_verification
       end
     else
      return render_incorrect_email
     end
   else
     return render_incorrect_number_of_parameters
   end
  end




  private

  #for methood forgot
  def render_successfully_created_new_validation
    render status: :ok, json: {success: I18n.t('render.errors.password.Email_send_successfull')}
  end

  def render_unable_to_create_new_verification
    render status: :unprocessable_entity, json: {error: @verification.errors.full_messages}
  end

  def render_incorrect_email
    render status: :unauthorized, json: {error: I18n.t('render.errors.password.Incorrect_Email')}
  end

  # for methood forgot end

  # for methood reset
  def render_password_change_successfull
    render status: :ok, json: {success: I18n.t('render.errors.password.successfull')}
  end

  def render_password_change_unsuccessfull
    render status: :unprocessable_entity, json: {error: @current_user.auth.errors.full_messages}
  end

  def render_incorrect_password
    render status: :unauthorized, json: {error: I18n.t('render.errors.password.Previous_Password_not_match')}
  end

  def render_incorrect_number_of_parameters
    render status: :unprocessable_entity, json: {error: I18n.t('render.errors.Invalid_params')}
  end
  # for methood reset end

  def reset_params
    params.permit(:password,:password_confirmation)
  end
end
