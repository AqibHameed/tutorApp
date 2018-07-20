class Auth::VerificationsController < ApplicationController
  before_action :authenticate_user, only: [:validate,:new_pin]
  def validate
    #@current_user = User.find(params[:id])
    if params[:verification_pin].present?
        @verification_array = @current_user.verifications.where(verification_status: 0, verification_pin: params[:verification_pin].to_s,verification_type: 0)
        @verification = @verification_array.last
        if @verification.nil?
          return render_invalid_pin
        else
          if @verification.created_at < TIME_FOR_PIN_TO_EXPIRE.minute.ago
            @verification.update(verification_status: VERIFICATION_STATUS_DELAYED)
            return render_verification_timeout
          else
            if @current_user.auth.update_attribute(:status, AUTH_STATUS_CONFIRMED)
               if @verification.update(verification_status: VERIFICATION_STATUS_VERIFIED)
                return render_verification_successful
               else
                 return render_unable_to_update_verification_status
               end
            else
              return render_unable_to_update_status
            end
          end
        end
    else
      return render_no_params
    end
  end

  def reset # we will send pin along with password information
    if params[:verification_pin].present?
      @verification = Verification.find_by(verification_pin: params[:verification_pin].to_s,verification_status: 0, verification_type: 1)
      if !@verification.nil?
        @user = @verification.user
        if @verification.created_at < TIME_FOR_PIN_TO_EXPIRE.minute.ago
          @verification.update(verification_status: VERIFICATION_STATUS_DELAYED)
          return render_verification_timeout
        else
          if @user.auth.update(reset_params)
            if @verification.update(verification_status: VERIFICATION_STATUS_VERIFIED)
              return render_password_verification_success
            else
              return render_unable_to_update_reset_verification_status
            end
          else
            return render_password_reset_error
          end
        end
      else
        return render_invalid_pin
      end
    else
      return render_no_params
    end
  end

  def confirm # confirm through mail
    if params[:verification_pin].present?
      @verification = Verification.find_by(verification_pin: params[:verification_pin].to_s,verification_status: 0,verification_type: 0)
      if !@verification.nil?
        @current_user = @verification.user
        if @verification.created_at < TIME_FOR_PIN_TO_EXPIRE.minute.ago
          @verification.update(verification_status: VERIFICATION_STATUS_DELAYED)
          return render_verification_timeout
        else
          if @current_user.auth.update_attribute(:status, AUTH_STATUS_CONFIRMED)
            if @verification.update(verification_status: VERIFICATION_STATUS_VERIFIED)
              redirect_to ('/varification.html')
             # redirect_to('http://localhost:3000/Users/tahaali/rails/newzician/public/varification.html')
              #   return render_verification_successful
            else
              return render_unable_to_update_verification_status
            end
          else
            return render_unable_to_update_status
          end
        end
      else
        return render_invalid_pin
      end
    else
      return render_no_params
    end
  end

  def new_pin # if a user's pin expired he would need to request a new one
    if @current_user.auth.status == 1
      return render_unable_to_create_verification_for_new_pin
    else
      @verification = @current_user.verifications.build(verification_type: VERIFICATION_TYPE_STANDARD)
      if @verification.save
      else
        return render_user_already_verified
      end
    end
  end


private

  def render_user_already_verified
    render status: :unprocessable_entity, json: {errors: @verification.errors.full_messages}
  end

  def render_unable_to_create_verification_for_new_pin
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.verification.user_already_verified')}
  end


  def render_unable_to_update_reset_verification_status
    render status: :unprocessable_entity, json: {errors: @verification.errors.full_messages}
  end

  def render_password_reset_error
    render status: :unprocessable_entity, json: {errors: @user.auth.errors.full_messages}
  end

  def render_unable_to_update_status
    render status: :unprocessable_entity, json: {errors: @current_user.errors.full_messages}
  end


  def render_password_verification_success
    render status: :ok , json:{success: I18n.t('render.errors.verification.successfull')}
  end

  def render_verification_successful
    render status: :ok , json:{success: I18n.t('render.errors.verification.successfully_confirmed')}
  end

  def render_invalid_pin
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.verification.Invalid_Pin')}
  end

  def render_verification_timeout
    render status: :forbidden, json: {errors: I18n.t('render.errors.verification.Pin_timeout')}
  end

  def render_no_params
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.Invalid_params')}
  end

  def render_unable_to_update_verification_status
    render status: :unprocessable_entity, json: {errors: @verification.errors.full_messages}
  end

  def reset_params
    params.permit(:password,:password_confirmation)
  end

end

# remember to make a directory Auth we need to
# 1) add the namespace/scope in the routes.rb files
# 2) add the __::class where__ => the folder name with first letter capital
# 3) changes in views file of mailer