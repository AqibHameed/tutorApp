class ApiControllerController < ActionController::API

  def authenticate_user_from_id_and_token!

    user = User.find_by_authentication_token(params[:stoken])

    if user.nil?
      render json: {success: false, message: "Unauthorized User"}, status: 401
    end

  end

end
