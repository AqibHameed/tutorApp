class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :update, :destroy]

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
