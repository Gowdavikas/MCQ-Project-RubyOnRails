ActiveAdmin.register Academic do
  permit_params :college_name, :career_goals, :language, :other_language, :currently_working, :specialization, :experience, :availability, :interest_id, :qualification_id, :user_id
end
