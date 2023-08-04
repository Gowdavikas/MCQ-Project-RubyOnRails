require 'rails_helper'

RSpec.describe Interest, type: :feature do

    before do
        admin_user = AdminUser.create(email: 'admin@example.com',password: "password", password_confirmation: "password")
        login_as(admin_user, scope: :admin_user)
        visit admin_admin_users_path
    end

    describe "Qualification form" do
        it "renders the form for creating new qualification" do
            visit new_admin_qualification_path
            expect(page).to have_content('New Qualification')
            fill_in 'Name', with: 'Mca'
            click_button 'Create Qualification'
            expect(page).to have_content('Qualification was successfully created.')
        end
    end

    describe "CSV Import" do
        let(:csv_path) {Rails.root.join('spec', 'fixtures', 'files', 'qualification.csv')}

        it "imports qualifications from CSV file" do
            visit admin_root_path
            click_link "Qualifications"
            click_link "Import CSV"
            attach_file('qualification_csv_file', csv_path)
            click_button "Import CSV"
            expect(page).to have_content("CSV file imported successfully.")
            expect(Qualification.count).to eq(9)
        end

        it "returns an error message if CSV file is not uploaded" do
            visit admin_root_path
            click_link "Qualifications"
            click_link "Import CSV"
            click_button "Import CSV"

            expect(page).to have_content("No CSV file was uploaded.")
            expect(Qualification.count).to eq(0)
        end
    end

end