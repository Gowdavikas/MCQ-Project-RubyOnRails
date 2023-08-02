require 'rails_helper'

RSpec.describe AnswersController, type: :request do

  describe "GET /index" do
    it "returns a list of answer details" do
      user = User.create(name: "Jackie", role: "admin", phonenumber: "95913301819", email: "jackieson@gmail.com", password: "12345678")
      question = Question.create(question: "What is rspec in ruby?", level: "level_1", codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise", userAnswer: "devise", expectedResult: true, user_id: user.id, question_id: question.id)
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      get "/answers", headers: { 'token' => 'YOUR_VALID_JWT_TOKEN' }
      expect(response).to have_http_status(200)
    end

    it "returns a 'No answer details found' error message" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      get "/answers", headers: { 'token' => 'Bearer YOUR_VALID_JWT_TOKEN' }
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show" do
    it "returns a specific answer detail" do
      user = User.create(name: "Ufser@123", role: "user", phonenumber: "95913301819", email: "vaalid_user@gmail.com", password: "12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      @valid_jwt_token = JWT.encode({ sub: user.id, exp: Time.now.to_i + 3600 }, 'YOUR_SECRET_KEY', 'HS256')
      get "/answer/1", headers: {"token" => @valid_jwt_token}
      json_response= JSON.parse(response.body)
      p json_response
      expect(response).to have_http_status(200)
    end

    it "returns an error for invalid user" do
      user = User.create(name: "", role: "user", phonenumber: "95913301819", email: "vaalid_user@gmail.com", password: "12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      @valid_jwt_token = JWT.encode({ sub: user.id, exp: Time.now.to_i + 3600 }, 'YOUR_SECRET_KEY', 'HS256')
      get "/answer/1", headers: {"token" => @valid_jwt_token}
      json_response= JSON.parse(response.body)
      p json_response
      expect(response).to have_http_status(404)
    end


    it "returns an error message when specific answer not found" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      get "/answer/invalid_id", headers: {"token" => "YOUR_VALID_JWT_TOKEN"}
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    it "creates a new answer details" do
      user = User.create(name: "navid",role: "admin",phonenumber: "95913301819",email: "cristie@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      params = {correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id}
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      post "/answer", headers: {"token" => "YOUR_VALID_JWT_TOKEN"}, params: {answer: params}
      expect(response).to have_http_status(201)
    end

    it " returns an error message when answer failed to create" do
      user = User.create(name: "niniai",role: "admin",phonenumber: "95913301819",email: "crist@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      params = {correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id}
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      post "/answer", headers: {"token" => "YOUR_VALID_JWT_TOKEN"}, params: {answer: params}
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update" do
    it "updates the specific answer details" do
      user = User.create(name: "jaq",role: "admin",phonenumber: "95913301819",email: "jagqlie@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      params = {correctAnswer: "LOCAL",userAnswer: "local",expectedResult: false,user_id: user.id,question_id: question.id}
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      patch "/answer/1", params: {answer: params}, headers: {"token" => "YOUR_VALID_JWT_TOKEN"}
      expect(response).to have_http_status(200)
    end
  end

  describe "POST/ Submit_answer" do
    context "when the user is authenticated with a valid token and has not submitted answers previously" do
      before do
        @valid_user = User.create(name: "User@123", role: "user", phonenumber: "95913301819", email: "valid_user@gmail.com", password: "12345678")
        @valid_jwt_token = JWT.encode({ user_id: @valid_user.id }, 'YOUR_SECRET_KEY', 'HS256')
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:auth_user).and_return(@valid_user)
      end

      it "creates and saves new answer records and returns the score" do
        question = Question.create(question: "What is rspec in ruby?", level: "level_1", codeLanguage: "Ruby")
        answers_params = [
          { question_id: question.id, answer: "RSpec" }
        ]

        post "/submitanswer", params: { answers: answers_params }, headers: { "token" => @valid_jwt_token }

        expect(response).to have_http_status(200)
        response_data = JSON.parse(response.body)
        total_questions = answers_params.length
        total_correct_answers = response_data["correct_answers"]
        expected_score = (total_correct_answers.to_f / total_questions) * 100
        expect(response_data).to include("message" => "Your marks has been sent successfully to your provided email-id", "score" => a_value_within(0.1).of(expected_score))
      end
    end
  end
end
