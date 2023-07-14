ActiveAdmin.register Academic do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :college_name, :career_goals, :language, :other_language, :currently_working, :specialization, :experience, :availability, :interest_id, :qualification_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:college_name, :career_goals, :language, :other_language, :currently_working, :specialization, :experience, :availability, :interest_id, :qualification_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
