require 'rails_helper'

RSpec.describe InterestsController, type: :request do
  describe "GET /index" do
    before do
      Interest.destroy_all
    end
    it "returns all interests" do
      interest = Interest.create(name: "Artificial Intelligence")
      get "/interests"
      expect(response).to have_http_status(200)
    end

    it "returns an error message when no interests found" do
      get "/interests"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /show" do
    it "returns specific interest" do
      interest = Interest.create(name: "Data analyst")
      get "/interest/#{interest.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message when specified details not found" do
      get "/interest/invalid_id"
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    it "Creates new interest" do
      interest_params = {name: "React-js"}
      post "/interest", params: {interest: interest_params}
      expect(response).to have_http_status(201)
    end

    it "Returns an error message, when interest not created successfully" do
      interest_params = {name: ""}
      post "/interest", params: {interest: interest_params}
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update" do
    it "updates the specific interest details" do
      interest = Interest.create(name: "Java")
      interest_params = {name: "Java-full stack"}
      put "/interest/#{interest.id}", params: {interest: interest_params}
      expect(response).to have_http_status(200)
    end

    it "returns an error message when it fails to update" do
      interest = Interest.create(name: "Java")
      interest_params = {name: ""}
      put "/interest/1", params: {interest: interest_params}
      expect(response).to have_http_status(400)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes the specific record" do
      interest = Interest.create(name: "Python")
      delete "/interest/#{interest.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if it fails to delete the specific record" do
      delete "/interest/invalid_id"
      expect(response).to have_http_status(400)
    end
  end

end
