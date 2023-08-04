require 'rails_helper'

RSpec.describe Interest, type: :feature do

    before do
        admin_user = AdminUser.create(email: 'admin@example.com',password: "password", password_confirmation: "password")
        login_as(admin_user, scope: :admin_user)
        visit admin_admin_users_path
    end

    describe "Interest form" do
        it "renders the form for creating a new interest" do
            visit new_admin_interest_path
            expect(page).to have_content('New Interest')
            fill_in 'Name', with: 'Ruby on rails'
            click_button 'Create Interest'
            expect(page).to have_content('Interest was successfully created.')
        end
    end

    describe "CSV Import" do
        let(:csv_path) {Rails.root.join('spec', 'fixtures', 'files', 'interest.csv')}
        let(:invalid_csv_path) {Rails.root.join('spec', 'fixtures', 'files', 'invalidcsv')}

        it "imports interests from CSV file" do
            visit admin_root_path
            click_link "Interests"
            click_link "Import CSV"
            attach_file('interest_csv_file', csv_path)
            click_button "Import CSV"
            expect(page).to have_content("CSV file imported successfully.")
            expect(Interest.count).to eq(5)
        end

        it "returns an error message if CSV file is not uploaded" do
            visit admin_root_path
            click_link "Interests"
            click_link "Import CSV"
            click_button "Import CSV"

            expect(page).to have_content("No CSV file was uploaded.")
            expect(Interest.count).to eq(0)
        end
    end
end