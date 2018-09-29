json.extract! @user,  :id, :name, :email, :username, :gender

if params[:student_id].present?
  json.id @user.student.id
  json.price @user.student.price
  if @user.student.timing.present?
    json.timing @user.student.timing.localtime.strftime("%I:%M %p")
  else
    json.timing ""
  end
elsif params[:tutor_id].present?
  json.id @user.tutor.id
  json.education @user.tutor.education
  json.experience @user.tutor.experience
  json.fees @user.tutor.fees
end