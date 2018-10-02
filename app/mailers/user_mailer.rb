class UserMailer < ApplicationMailer
  default from: "azarpadana@gmail.com"

  def email_to_admin(user_details)
    @user_details = user_details
    mail(to: AdminUser.first.email, subject: @user_details[:subject])
  end

end
