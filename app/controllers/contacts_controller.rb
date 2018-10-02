class ContactsController < ApplicationController

  def news_letter

      @news_letter = NewsLetter.new(news_letter_params)

      if @news_letter.save
        render status: :ok , json: {message: "You have successfully subscribed to our latest news"}
      else
        render status: :unprocessable_entity, json: {errors: @news_letter.errors.full_messages}
      end

  end

  def contact_us
      user_details = params[:user]
      UserMailer.email_to_admin(user_details).deliver
      render status: :ok , json: {message: "Email sent successfully"}
  end

  private

  def news_letter_params
      params.permit(:email, :user_id, :student_id, :tutor_id)
  end

end
