class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :update, :destroy]


=begin
 @apiVersion 1.0.0
 @api {get} subjects
 @apiName list of subjects
 @apiGroup Subject
 @apiDescription list of all subjects
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

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :code)
    end
end
