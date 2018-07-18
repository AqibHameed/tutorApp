class AdminsController < ApplicationController

  def pending_subjects
    @subjects = Subject.where(approved:false)
    if !@subjects.nil?
    render status: :ok, template: "subjects/index"
    else
      render status: :bad_request, json: {errors: "Their is no unapproved subjects for now"}
    end
  end

  def approve_subjects
    if params[:subject_id].present?
      @subject = Subject.find(params[:subject_id])
      if !@subject.nil?
        @subject.update(approved:true)
        render status: :ok, template: "subjects/show"
      else
      render status: :bad_request, json: {errors: "subject_id is Invalid"}  
      end  
    else
      render status: :not_found, json: {errors: "subject_id not found"}
    end  

  end

  def disapprove_subject
     @subject = Subject.where(id:params[:subject_id],approved:"false")
     @subject.destroy_all
  end  



  def pending_request
    @requests = Request.where(status:false).order(created_at: :desc)
    #byebug
    render status: :ok, template: "requests/index"
  end

  def assign_request
    if params[:tutor_id].present? && params[:request_id].present?
      @request = Request.find(params[:request_id])
      #@tutor   = User.find_by(tutor_id:params[:tutor_id])
      if @request.status == false
        @request.status = true
        # if !@tutor.nil?
        @request.tutor_id = params[:tutor_id]
        @request.update(tutor_id: params[:tutor_id])
        render status: :ok, template: "requests/show"
        # else
        #   render status: :not_found , json: {errors: "Invalid Tutor Id"} 
        # end
      else
        render status: :bad_request, json: {errors: "request already assigned"}    
      end  
    else
      render status: :not_found , json: {errors: "tutor_id or request_id is not set"} 
    end
  end

end
