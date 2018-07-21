class Auth::SessionsController < ApplicationController
  before_action :authenticate_user, only: [:destroy,:signout]


=begin
 @apiVersion 1.0.0
 @api {post} auth/signin
 @apiName User Sign IN
 @apiGroup Auth
 @apiDescription Sign In for user
  @apiParamExample {json} Request-Example:
{
  "username":"a@a",
  "password":"Password1"
}
 @apiSuccessExample {json} SuccessResponse:
   [
    {
      "sid": 11,
      "stoken": "GqLYfU8eGkaJ",
      "user": {
        "name": "taha",
        "email": "a@.gm.com",
        "username": "a@a",
        "gender": true
      }
}
   ]
=end




  def create
    if params[:username].present? and params[:password].present?
      @user = User.find_by(username: params[:username].to_s)
      if !@user.nil?
       @auth = @user.auth
        if @auth.authenticate(params[:password])
          @session = @user.sessions.build
          if @session.save
            return render_user_sucessfully_signedin
          else
            return render_error_session_not_saved
          end
        else
          return render_error_password_not_matched
        end
      else
        return render_error_user_does_not_exist
      end
    else
      return render_params_not_sent
    end
  end



=begin
 @apiVersion 1.0.0
 @api {delete} auth/signout
 @apiName Sign Out
 @apiGroup Auth
 @apiDescription User Sign Out
  @apiHeaderExample {json} Header-Example:
    {
        "sid": "2"
        "stoken":"wNJBYeyqHkbU"
    }  
=end


  def signout
   if @current_session.update(sign_in_status: false)
     return render_user_sign_out
   else
     render status: :unprocessable_entity, json: {errors: @current_session.errors.full_messages}
   end
  end


  private

  def render_user_sign_out
    render status: :ok, json: {success: I18n.t('render.errors.session.sign_out')}
  end


  def render_user_sucessfully_signedin
    render status: :created, template: "users/sign_in"
  end

  def render_error_session_not_saved
    render status: :unprocessable_entity, json: {errors: @session.errors.full_messages}
  end

  def render_error_password_not_matched
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.session.Incorrect_Password')}
  end

  def render_error_user_does_not_exist
    render status: :unprocessable_entity, json: {errors:  I18n.t('render.errors.session.Username_not_found')}
  end

  def render_params_not_sent
    render status: :unprocessable_entity, json: {errors: I18n.t('render.errors.Invalid_params')}
  end
end
