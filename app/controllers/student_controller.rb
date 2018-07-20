class StudentController < ApplicationController
	before_action :authenticate_user
  def create_request
		@student = @current_user.student
  		if params[:subject_id].present?
  			@request = Request.new(student:@student,subject_id:params[:subject_id].to_i)
  			if @request.save
  			render status: :created, template: "requests/show"
  			else
  			render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}	
  			end
  		else
  		render status: :not_found , json: {errors: I18n.t('students.error.Subject_ID_not_found')}	
  		end
  end

  def check_request
    @student = @current_user.student
      @requests = Request.where(student:@student)
      unless @requests.nil?
        render status: :ok ,template: "requests/index"
      end 
  end  
	

end
