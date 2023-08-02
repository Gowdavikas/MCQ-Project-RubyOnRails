require 'rails_helper'

RSpec.describe AcademicsController, type: :request do
  describe "GET /index" do
    it "returns all academic" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "bradpito",role: "admin",phonenumber: "95913301819",email: "bradpito@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "sssssssss",career_goals: "sdfahkajhvv",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      get "/academics"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "returns a specific academic" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "jsg",role: "admin",phonenumber: "95913301819",email: "shj@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "MITE",career_goals: "sdfahkajhvv",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      get "/academic/1"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specified academic not found" do
      get "/academic/invalid_id"
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    it "creates a new academic" do
      interest = Interest.create(name: "Java spring boot")
      qualification = Qualification.create(name: "Bca")
      user = User.create(name: "Sceen",role: "user",phonenumber: "95913301819",email: "seeb@gmail.com",password:"12345678")
      sign_in(user)
      academic_params = {college_name: "ST.joh",career_goals: "scscsc",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id}
      post "/academic", params: academic_params
      expect(response).to have_http_status(201)
    end

    it "returns an error message if new academic not created" do
      interest = Interest.create(name: "Java spring boot")
      qualification = Qualification.create(name: "Bca")
      user = User.create(name: "Sceena",role: "user",phonenumber: "95913301819",email: "seeba@gmail.com",password:"12345678")
      sign_in(user)
      academic_params = {college_name: "ST.johns",career_goals: "scscscsc",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id}
      post "/academic"
      expect(response).to have_http_status(400)
    end
  end

  describe 'serialization' do
    it 'includes the correct CV URL when cv is present' do
      interest = Interest.create(name: "Java spring boot")
      qualification = Qualification.create(name: "Bca")
      user = User.create(name: "Sceen",role: "user",phonenumber: "95913301819",email: "seeb@gmail.com",password:"12345678")
      sign_in(user)
      academic = Academic.create(college_name: "ST.joh",career_goals: "scscsc",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id,cv: fixture_file_upload('C:/Users/SPURGE/ROR-Projects/McqTest/spec/fixtures/files/cv.png', 'image/png'))
      serialized_academic = AcademicSerializer.new(academic).serializable_hash
      expect(serialized_academic[:cv]).to include('/rails/active_storage/blobs/')
    end
  
      it 'includes the correct Govt ID URL when govt_id is present' do
      interest = Interest.create(name: "Java spring boot")
      qualification = Qualification.create(name: "Bca")
      user = User.create(name: "Sceen",role: "user",phonenumber: "95913301819",email: "seeb@gmail.com",password:"12345678")
      sign_in(user)
      academic = Academic.create(college_name: "ST.joh",career_goals: "scscsc",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id,govt_id: fixture_file_upload('C:/Users/SPURGE/ROR-Projects/McqTest/spec/fixtures/files/govt.png', 'image/png'))
      serialized_academic = AcademicSerializer.new(academic).serializable_hash
      expect(serialized_academic[:govt_id]).to include('/rails/active_storage/blobs/')
      end
  end


  describe "PUT /update" do
    it "updates specific academic" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "qwer",role: "admin",phonenumber: "95913301819",email: "hsgs@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "MITE",career_goals: "sdsssfahkajhvv",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      sign_in(user)
      params = {college_name: "KVGCE"}
      put "/academic/1", params: {academic_params: params}
      expect(response).to have_http_status(200)
    end

    it "returns an error when academic failed to update" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "qwer",role: "admin",phonenumber: "95913301819",email: "hsgs@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "MITE",career_goals: "sdsssfahkajhvv",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      sign_in(user)
      academic_params = {college_name: "dd"}
      put "/academic/1", params: academic_params
      expect(response).to have_http_status(200)
    end
  end

  describe "Delete /destroy" do
    it "deletes specific academic" do
      interest = Interest.create(name: "Artificial Intelligence")
      qualification = Qualification.create(name: "MCA")
      user = User.create(name: "Sachin",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      academic = Academic.create(college_name: "MITE",career_goals: "sdfahkajhvv",language: "Kannada",other_language: "English, Hindi",currently_working: true,specialization: "Engineering",experience: "1 year 6 months",availability: false,interest_id: interest.id,qualification_id: qualification.id,user_id: user.id)
      delete "/academic/1"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specified academic not deleted" do
      delete "/academic/invalid_id"
      expect(response).to have_http_status(400)
    end
  end
end
