class Auth::TokenValidationsController < ApplicationController
  #simple validation of tokens
  before_action :authenticate_user, only: [:validate]

  def validate
    if @current_user
      return render_token_available
    else
      return render_token_unavailable
    end
  end



  private
  def render_token_available
    render status: :ok, template: "users/validate_token"
  end
  def render_token_unavailable
    render status: :no_content
  end

end

