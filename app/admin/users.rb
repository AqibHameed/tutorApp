ActiveAdmin.register User do
  permit_params :name, :info, :user_type, :email, :username, :about, :gender, :user_status, :waiting_status, :phone, :address, :degree, :year_of_completion, :institution, :majors, :expectation, :martial_status, :age
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
