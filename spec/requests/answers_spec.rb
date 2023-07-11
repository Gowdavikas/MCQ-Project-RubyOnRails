require 'rails_helper'

RSpec.describe AnswersController, type: :request do
  describe "GET /index" do
    it "returns a list of answer details" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      get "/answers"
      expect(response).to have_http_status(200)
    end

    it "returns a'No answer details found' error message" do
      get "/answers"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show" do
    it "returns a specific answer detail" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      get "/answer/#{answer.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message when specific answer not found" do
      get "/answer/invalid_id"
      expect(response).to have_http_status(404)
    end
  end


  describe "POST /create" do
    it "creates a new answer details" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      params = {correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id}
      post "/answer", params: {answer: params}
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /update" do
    it "updates the specific answer details" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      answer = Answer.create(correctAnswer: "devise",userAnswer: "devise",expectedResult: true,user_id: user.id,question_id: question.id)
      params = {correctAnswer: "LOCAL",userAnswer: "local",expectedResult: false,user_id: user.id,question_id: question.id}
      patch "/answer/#{answer.id}", params: {answer: params}
      expect(response).to have_http_status(200)
    end
  end

end
