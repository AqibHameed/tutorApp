class StudentController < ApplicationController
	before_action :set_student, only: [:create_request]

  def create_request
  	if params[:tutor_id].present?
  		if params[:subject_id].present?
  			@request = Request.new(student:@student,tutor_id:params[:tutor_id].to_i,subject_id:params[:subject_id].to_i)
  			if @request.save
  			render status: :created, template: "requests/show"
  			else
  			render status: :unprocessable_entity, json: {errors: @request.errors.full_messages}	
  			end
  		else
  		render status: :not_found , json: {errors: I18n.t('students.error.Subject_ID_not_found')}	
  		end
  	else
  		render status: :not_found , json: {errors: I18n.t('students.error.Tutor_ID_not_found')}
  	end	
  end

  private

  def set_student
  	@student = Student.find(params[:id])
  end

end
