class ContactsController < ApplicationController

  def news_letter

      @news_letter = NewsLetter.new(news_letter_params)

      if @news_letter.save
        render status: :ok , json: {message: "NewsLetter create successfully"}
      else
        render status: :unprocessable_entity, json: {errors: @news_letter.errors.full_messages}
      end

  end

  def email_send
  end

  private

  def news_letter_params
      params.permit(:email, :user_id, :student_id, :tutor_id)
  end

end
