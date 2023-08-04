require 'rails_helper'

RSpec.describe Question, type: :feature do

    before do
        admin_user = AdminUser.create(email: 'admin@example.com',password: "password", password_confirmation: "password")
        login_as(admin_user, scope: :admin_user)
        visit admin_admin_users_path
    end
    describe 'Question form' do
        it 'renders the form for creating a new Question' do
            visit new_admin_question_path
    
            expect(page).to have_content('New Question')
    
            fill_in 'question_question', with: 'What is ActiveAdmin?'
            select 'level_2', from: 'question_level'
            select 'Ruby', from: 'question_codeLanguage'
            # fill_in 'option_option', with: 'A framework for building admin interfaces'
            
            click_button 'Create Question'
    
            expect(page).to have_content('Question was successfully created.')
        end
    end
    
    describe "CSV Import" do
        
        let(:csv_path) { Rails.root.join('spec', 'fixtures', 'files', 'question.csv') }
        let(:invalid_csv_path) { Rails.root.join('spec', 'fixtures', 'files', 'question_invalid.csv') }

        it "imports questions from a CSV file" do
            visit admin_root_path
            click_link "Questions"
            click_link "Import CSV"
            attach_file('question_csv_file', csv_path)
            click_button "Import CSV"

            expect(page).to have_content("CSV file imported successfully.")
            expect(Question.count).to eq(4)
        end

        it "returns an error message if CSV file is not uploaded" do
            visit admin_root_path
            click_link "Questions"
            click_link "Import CSV"
            click_button "Import CSV"
        
            expect(page).to have_content("No CSV file was uploaded.")
            expect(Question.count).to eq(0)
        end
    end
end