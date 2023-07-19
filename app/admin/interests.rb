require 'csv'
ActiveAdmin.register Interest do
  
  permit_params :name
  form do |f|
    f.inputs do
      f.input :name
    end
  f.actions
  end
  member_action :download_csv, method: :get do
     interest = Interest.find(params[:id])
     send_data interest.to_csv, filename: "interest_#{interest.id}.csv"
    end
    
    action_item :import_csv, only: :index do
     link_to 'Import CSV', new_import_csv_admin_interests_path
    end
    
    collection_action :new_import_csv, method: :get do
     @interest = Interest.new
     render 'admin/interests/import_csv'
    end
    
    collection_action :import_csv, method: :post do
     if params[:interest] && params[:interest][:csv_file]
     csv_file = params[:interest][:csv_file]
     if csv_file.present?
      begin
      CSV.foreach(csv_file.path, headers: true) do |row|
       Interest.create(name: row['name'])
      end
      redirect_to admin_interests_path, notice: 'CSV file imported successfully.'
      rescue StandardError => e
      redirect_to new_import_csv_admin_interests_path, alert: "Error importing CSV file: #{e.message}"
      end
     else
      redirect_to new_import_csv_admin_interests_path, alert: 'No CSV file was uploaded.'
     end
     else
     redirect_to new_import_csv_admin_interests_path, alert: 'No CSV file was uploaded.'
     end
  end
end
