class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user ,only: [:updated]


  def index
    @users = User.all
  end


  def show
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     if params[:role].present?
  #       if params[:role] == 1
  #         unless params[:subjects].nil?
  #           @tutor = @user.build_tutor(tutor_params)
  #           @subject_from_user = params[:subjects]
  #           @subject_from_user.each do |s|
  #           @subject = Subject.new(name:s,approved:false)
  #             if @subject.save
  #               @tutor.subjects << @subject
  #             else
  #                render status: :unprocessable_entity, json: {errors: @subject.errors.full_messages}
  #             end
  #           end
  #         end
  #           if @tutor.save
  #             render status: :created, template: "users/show"
  #           else
  #              @user.destroy
  #              render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
  #           end
  #       elsif params[:role] == 0
  #         @student = @user.build_student(student_params)
  #           if @student.save
  #             render status: :created, template: "users/show"
  #           else
  #             @user.destroy
  #             render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
  #           end
  #       elsif params[:role] == 2
  #         @student = @user.build_student(student_params)
  #           if @student.save
  #             #render status: :created, template: "users/show"
  #           else
  #             @user.destroy
  #             render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
  #           end
  #         @tutor = @user.build_tutor(tutor_params)
  #           unless params[:subjects].nil?
  #             @tutor = @user.build_tutor(tutor_params)
  #             @subject_from_user = params[:subjects]
  #             @subject_from_user.each do |s|
  #             @subject = Subject.new(name:s,approved:false)
  #               if @subject.save
  #                 @tutor.subjects << @subject
  #               else
  #                  render status: :unprocessable_entity, json: {errors: @subject.errors.full_messages}
  #               end
  #             end
  #           end
  #           if @tutor.save
  #             render status: :created, template: "users/show"
  #           else
  #              @user.destroy
  #              render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
  #           end
  #       end
  #     else
  #     render :show, status: :created, location: @user
  #     end
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  def updated
    @user = @current_user
    if @user.update(user_params)
      if params[:user_type].present?
        if params[:user_type] == 1
          @tutor = @user.build_tutor(tutor_params)
           unless params[:subjects].nil?
              @tutor = @user.build_tutor(tutor_params)
              @subject_from_user = params[:subjects]
              @subject_from_user.each do |s|
              @subject = Subject.new(name:s,approved:false)
                if @subject.save
                  @tutor.subjects << @subject
                end 
              end 
           end  
            if @tutor.save
              render status: :created, template: "users/show"
            else
               render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
            end
        elsif params[:user_type] == 0
            @student = @user.build_student(student_params)
              if @student.save
                render status: :created, template: "users/show"
              else
                render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
              end  
        elsif params[:user_type] == 2
            @student = @user.build_student(student_params)
              if @student.save
              else
                render status: :unprocessable_entity, json: {errors: @student.errors.full_messages}
              end
               @tutor = @user.build_tutor(tutor_params)
                unless params[:subjects].nil?
                  @tutor = @user.build_tutor(tutor_params)
                  @subject_from_user = params[:subjects]
                  @subject_from_user.each do |s|
                  @subject = Subject.new(name:s,approved:false)
                    if @subject.save
                      @tutor.subjects << @subject
                    else  
                      # render status: :unprocessable_entity, json: {errors: @subject.errors.full_messages}
                    end 
                  end 
                end  
              if @tutor.save
                render status: :created, template: "users/show"
              else
                 render status: :unprocessable_entity, json: {errors: @tutor.errors.full_messages}
              end
        end
      else
      render :show, status: :ok, location: @user  
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def student_params
      params.permit(:price,:timing)
    end  

    def tutor_params
      params.permit(:education, :experience, :availablity ,subject_ids:[])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :info, :user_type)
    end
end
