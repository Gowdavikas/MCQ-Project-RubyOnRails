require 'rails_helper'

RSpec.describe QuestionsController, type: :request do
  describe "GET /index" do
    context "when valid pagination parameters are provided" do
      before do
        30.times do |i|
          Question.create(question: "What is rspec in ruby on rails?",level: "level_1",codeLanguage: "Ruby")
        end
      end

      it "returns a list of questions with pagination data" do
        user = User.create(name: "User", role: "admin", email: "admin123@example.com", password: "password")
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        get "/questions", params: { page: 1, perpage: 10 }
        expect(response).to have_http_status(200)
      end
    end

    context "when invalid pagination parameters are provided" do
      it "returns an error message" do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
        get "/questions", params: { page: 0, perpage: -5}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "GET /show" do
    it "returns a specific question details" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "What is rspec in ruby??",level: "level_1",codeLanguage: "Ruby")
      get "/question/#{question.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specified details not found" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "What is rspec in ruby???",level: "level_1",codeLanguage: "Ruby")
      get "/question/invali_id"
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /create" do
    it "creates new record of question" do
      user = User.create(name: "User", role: "admin", email: "admin123@example.com", password: "password")
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      question_params = {question: "What is rspec?",level: "level_1",codeLanguage: "Ruby"}
      post "/question", params: {question: question_params}
      expect(response).to have_http_status(201)
    end

    it "return an error message if it fails to create new record" do
      user = User.create(name: "User", role: "user", email: "user@example.com", password: "password")
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      question_params = {question: "What is ruby?",level: "level_1",codeLanguage: "Ruby"}
      post "/question", params: {question: question_params}
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update" do
    it " updates the specified question" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "What is ruby on rails?",level: "level_1",codeLanguage: "Ruby")
      params = {question: "Gem to add images in ruby?",level: "level_2",codeLanguage: "Ruby"}
      put "/question/#{question.id}", params:{question: params}
      expect(response).to have_http_status(200)
    end

    it "returns an error message, when fails to update the specified record" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "Gem to add images in ruby?",level: "level_1",codeLanguage: "Ruby")
      params = {question: "",level: "level_2",codeLanguage: "Ruby"}
      put "/question/1",params:{question: params}
      expect(response).to have_http_status(400)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes the specific question" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "What is rspec in python?",level: "level_1",codeLanguage: "Ruby")
      delete "/question/#{question.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if question id is not found" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      question = Question.create(question: "What is rspec in rb?",level: "level_1",codeLanguage: "Ruby")
      delete "/question/invalid_id"
      expect(response).to have_http_status(400)
    end
  end

  describe "GET /getquestion" do
    GET_QUESTION = "/getquestion"
    context "when user is authenticated and has 'user' role" do

      before do
        @valid_user = User.create(name: "User@123", role: "user", phonenumber: "95913301819", email: "valid_user@gmail.com", password: "12345678")
        @valid_jwt_token = JWT.encode({ user_id: @valid_user.id }, 'YOUR_SECRET_KEY', 'HS256')
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:auth_user).and_return(@valid_user)
        30.times do |i|
          Question.create(question: "Question #{i + 1}", level: "level_1", codeLanguage: "Ruby")
        end
      end

      it "returns random questions based on level and codeLanguage" do
        level = "level_1"
        code_language = "Ruby"
        get GET_QUESTION, params: { level: level, codeLanguage: code_language }, headers: { "token" => @valid_jwt_token }

        expect(response).to have_http_status(200)
      end

      it "returns an error message if no questions are found for the specified criteria" do
        level = "level_99"
        code_language = "Python"
        get GET_QUESTION, params: { level: level, codeLanguage: code_language }, headers: { "token" => @valid_jwt_token }

        expect(response).to have_http_status(404)
      end
    end

    context "when user is not authenticated" do
      it "returns unauthorized status" do
        get GET_QUESTION, params: { level: "level_1", codeLanguage: "Ruby" }, headers: { "token" => @valid_jwt_token }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
