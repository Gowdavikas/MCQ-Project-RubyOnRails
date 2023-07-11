require 'rails_helper'

RSpec.describe OptionsController, type: :request do
  describe "GET /index" do
    it "return a list of all options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option_1: "active-storage",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id: 1)
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
      option = Option.create(option_1: "active-storage",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id: 1)
      get "/option/#{option.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if specific option is not found" do
      get "/option/invalid_id"
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /create" do
    it "Creates a new options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      params = {option_1: "active-storage",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id:question.id}
      post "/option", params: {option: params}
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /update" do
    it "Update the specific options" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option_1: "active-storage",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id: 1)
      params = {option_1: "jsonapi",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id:question.id}
      put "/option/#{option.id}", params:{option: params}
      expect(response).to have_http_status(200)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes specific option details" do
      question = Question.create(question: "Which gem is used for authentication?",level: "level_3",codeLanguage: "Ruby")
      option = Option.create(option_1: "active-storage",option_2: "devise",option_3: "devise-jwt",option_4: "rails-rspec",question_id: 1)
      delete "/option/#{option.id}"
      expect(response).to have_http_status(200)
    end
  end 
end
