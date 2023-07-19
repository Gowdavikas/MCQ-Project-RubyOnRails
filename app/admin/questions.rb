require 'csv'
ActiveAdmin.register Question do
    permit_params :question, :level, :codeLanguage, options_attributes: [:id, :option, :_destroy]
  
    form do |f|
      f.semantic_errors
      f.inputs do
        f.input :question
        f.input :level, as: :select, collection: ['level_1', 'level_2', 'level_3'], include_blank: true
        f.input :codeLanguage, as: :select, collection: ['React-native', 'React-Js', 'Java-full-stack', 'Ruby'], include_blank: true
      end
      f.inputs "Options" do
        f.has_many :options, allow_destroy: true, new_record: 'Add Options' do |o|
          o.input :option
        end
      end
      f.actions
    end 

    action_item :import_csv, only: :index do
      link_to 'Import CSV', new_import_csv_admin_questions_path
    end
    collection_action :new_import_csv, method: :get do 
      @question = Question.new
      render 'admin/questions/import_csv'
    end
    collection_action :import_csv, method: :post do
      if params[:question] && params[:question][:csv_file]
        csv_file = params[:question][:csv_file]
        if csv_file.present?
          begin
            CSV.foreach(csv_file.path, headers: true) do |row|
              params = row.to_h.slice('question', 'level', 'codeLanguage')
              options_params = row.to_h.slice('option1', 'option2', 'option3', 'option4').values.compact
              question = Question.new(params)
              options_params.each do |option_text|
                question.options.build(option: option_text)
              end
              question.save    
          end
          redirect_to admin_questions_path, notice: 'CSV file imported successfully.'
          rescue StandardError => e
            redirect_to new_import_csv_admin_questions_path, alert: "Error importing CSV file: #{e.message}"
          end
        else
        redirect_to new_import_csv_admin_question_path, alert: 'No CSV file was uploaded.'
        end
      else
        redirect_to new_import_csv_admin_questions_path, alert: 'No CSV file was uploaded.'
      end
    end
end
  