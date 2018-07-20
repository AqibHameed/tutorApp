class ApplicationController < ActionController::API
  def authenticate_user
    if request.headers['sid'].present? and request.headers['stoken'].present?
      session = Session.find_by(id: request.headers['sid'].to_i, stoken: request.headers['stoken'].to_s, sign_in_status: true)
      if !session.nil?
        if session.user.user_status == USER_STATUS_BLOCKED
          return render_user_blocked
        end
        @current_user = session.user
        @current_session = session
        #pundit_user
      else
        return render_invalid_tokens
      end
    else
      return render_error_unauthorized
    end

  end

  protected

  def user_not_authorized
    render status: :unauthorized, json: {errors: I18n.t('render.errors.application.user_not_authorize_pundit')}
  end

  #def pundit_user
   # @current_user
  #end


  private

  def render_user_blocked
    render status: :unauthorized, json: {errors: I18n.t('render.errors.application.user_blocked')}
  end

  def render_invalid_tokens
    render status: :bad_request, json: {errors: I18n.t('render.errors.application.invalid_tokens')}
  end

  def render_error_unauthorized
    render status: :unauthorized, json: {errors: I18n.t('render.errors.application.stoken_not_found')}
  end
end
