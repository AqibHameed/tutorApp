class Auth::TokenValidationsController < ApiControllerController
  #simple validation of tokens
  before_action :authenticate_user, only: [:validate]


=begin
 @apiVersion 1.0.0
 @api {get} auth/validate
 @apiName Validate
 @apiGroup Auth
 @apiDescription check that tokens are valid or not
  @apiHeaderExample {json} Header-Example:
    {
        "sid": "2"
        "stoken":"wNJBYeyqHkbU"
    }
   @apiSuccessExample {json} SuccessResponse:
   [
           {
        "user": {
          "name": "TAHA",
          "email": "d@aj.com",
          "username": "taha10",
          "gender": true,
          "student": {
            "id": 13,
            "price": 3,
            "timing": null,
            "user_id": 41,
            "created_at": "2018-07-20T13:47:22.873Z",
            "updated_at": "2018-07-20T13:47:22.873Z"
          }
        }
      }   
    ]
=end

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

