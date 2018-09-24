class SubjectsController < ApiControllerController
  before_action :authenticate_user_from_id_and_token!
  before_action :set_subject, only: [:show, :update, :destroy, :sub_search]


=begin
 @apiVersion 1.0.0
 @api {get} subjects
 @apiName list of subjects
 @apiGroup Subject
 @apiDescription list of all subjects
@apiParamExample {json} Request-Example:
{
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
   [
  {
    "id": 1,
    "name": "Mathematics",
    "code": null,
    "approved": true,
    "created_at": "2018-07-17T13:26:27.723Z",
    "updated_at": "2018-07-17T13:26:27.723Z",
    "url": "http://localhost:3000/subjects/1.json"
  }
   ]
=end

  def index
    @subjects = Subject.all
  end

  def show
  end

=begin
 @apiVersion 1.0.0
 @api {post} subjects/sub_search
 @apiName Subject Search
 @apiGroup Subject Search
 @apiDescription Search for Subject
  @apiParamExample {json} Request-Example:
{
  "id":"1",
  "stoken":"abcdfsg"
}
 @apiSuccessExample {json} SuccessResponse:
   [
    {
    "tutors": [
        {
            "id": 1,
            "education": "phd",
            "experience": "2years",
            "availablity": "Yes"
        },
        {
            "id": 2,
            "education": "MPhil",
            "experience": "1years",
            "availablity": "NO"
        }
    ]
}
   ]
=end
  def sub_search
     @tutors = @subject.tutors

      if @tutors.present?
          return render_show_tutors
      else
          return render_tutors_not_exist
      end


  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :code)
    end

    def render_show_tutors
       render status: :ok, template: "subjects/sub_search"
    end

    def render_tutors_not_exist
       render status: :ok, json: {success: "Tutor not exist"}
    end
end
