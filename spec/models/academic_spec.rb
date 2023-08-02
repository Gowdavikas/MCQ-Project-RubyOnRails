require 'rails_helper'

RSpec.describe Academic, type: :model do
  describe "associations" do
    it "belongs to an interest" do
      association = described_class.reflect_on_association(:interest)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to a qualification" do
      association = described_class.reflect_on_association(:qualification)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has one attached cv" do
      association = described_class.reflect_on_association(:cv_attachment)
      expect(association).to_not be_nil
    end

    it "has one attached govt_id" do
      association = described_class.reflect_on_association(:govt_id_attachment)
      expect(association).to_not be_nil
    end
  end

  
  describe 'validations' do
    it "valid academic" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "simba",role: "user",phonenumber: "95913301819",email: "simba@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "MITE",career_goals: "sdfahkajhvv",language: "french",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      expect(academic).to be_valid
    end
  end
end