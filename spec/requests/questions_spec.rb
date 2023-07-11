require 'rails_helper'

RSpec.describe QuestionsController, type: :request do
  describe "GET /index" do
    it "returns a list of questions" do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      get "/questions"
      expect(response).to have_http_status(200)
    end

    it "returns an error if no question exist" do
      get "/questions"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show/:id" do
    it "returns a specific question details" do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      get "/question/#{question.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specific details not found or details are not correct" do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      get "/question/invali_id"
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update/:id" do
    it " updates the specific question details " do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      params = {question: "Gem to add images in ruby?",level: "level_2",codeLanguage: "Ruby"}
      put "/question/#{question.id}",params:{question: params}
      expect(response).to have_http_status(200)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes the specific question" do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      delete "/question/#{question.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if question id is not found" do
      question = Question.create(question: "What is rspec in ruby?",level: "level_1",codeLanguage: "Ruby")
      delete "/question/invalid_id"
      expect(response).to have_http_status(400)
    end
  end
end
