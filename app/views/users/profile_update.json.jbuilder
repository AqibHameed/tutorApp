json.extract! @user,  :id, :name, :email, :username, :gender

if params[:student_id].present?
  json.id @user.student.id
  json.price @user.student.price
  json.timing @user.student.timing.strftime("%I:%M %p")
elsif params[:tutor_id].present?
  json.id @user.tutor.id
  json.education @user.tutor.education
  json.experience @user.tutor.experience
  json.fees @user.tutor.fees
end