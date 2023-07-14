require 'rails_helper'

RSpec.describe InterestsController, type: :request do
  describe "GET /index" do
    it "returns all interests" do
      interest = Interest.create(name: "Artificial Intelligence")
      get "/interests"
      expect(response).to have_http_status(200)
    end

    it "returns an error message, when no interest found" do
      get "/interests"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show" do
    it "returns specific interest" do
      interest = Interest.create(name: "Data science")
      get "/interest/#{interest.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message when specified details not found" do
      get "/interest/invalid_id"
      expect(response).to have_http_status(404)
    end
  end
end
