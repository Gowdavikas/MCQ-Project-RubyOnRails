require 'rails_helper'

RSpec.describe OptionsController, type: :request do
  describe "GET /index" do
    it "return a list of all options" do
      question = Question.create(question: "Which gem is used for authentication & authorization?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option: "devise",question_id: question.id)
      get "/options"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if no options found" do
      get "/options"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show" do
    it "returns a specific options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option: "rails-rspec",question_id: 1)
      get "/option/#{option.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specific option is not found" do
      get "/option/invalid_id"
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    it "Creates a new options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      params = {option: "rails-rspec",question_id:question.id}
      post "/option", params: {option: params}
      expect(response).to have_http_status(201)
    end

    it "returns an error message if it fails to create new record" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      params = {option: "",question_id:question.id}
      post "/option", params: {option: params}
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update" do
    it "Update the specific options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option: "devise-jwt",question_id: 1)
      params = {option: "rails-rspec",question_id:question.id}
      put "/option/#{option.id}", params:{option: params}
      expect(response).to have_http_status(200)
    end

    it "returns an error message if it fails to update a specific record" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option: "devise-jwt",question_id: 1)
      params = {option: "",question_id:question.id}
      put "/option/#{option.id}", params:{option: params}
      expect(response).to have_http_status(400)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes specific option details" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option: "active-storage",question_id: question.id)
      delete "/option/#{option.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specified record fails to delete" do
      delete "/option/invalid_id"
      expect(response).to have_http_status(400)
    end
  end 
end
