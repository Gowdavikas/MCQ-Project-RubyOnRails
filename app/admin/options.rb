ActiveAdmin.register Option do

  permit_params :option, :question_id
  
  form do |f|
    f.inputs do
      f.input :question_id, as: :select, collection: Question.pluck(:question, :id), include_blank: true
    end
    f.has_many :options, allow_destroy: true, new_record: 'Add Options' do |o|
      o.input :option, include_blank: true
    end
    f.actions
  end
end
