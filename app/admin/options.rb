ActiveAdmin.register Option do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :option_1, :option_2, :option_3, :option_4, :question_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:option_1, :option_2, :option_3, :option_4, :question_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
