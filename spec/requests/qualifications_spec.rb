require 'rails_helper'

RSpec.describe QualificationsController, type: :request do
  describe "GET /index" do
    it "returns a list of qualification details" do
      qualification = Qualification.create(name: "MCA")
      get "/qualifications"
      expect(response).to have_http_status(200)
    end

    it "return an error message if qualification not found" do
      get "/qualifications"
      expect(response).to have_http_status(404)
    end   
  end

  describe "GET /show" do
    it "returns a specific qualification detail" do
      qualification = Qualification.create(name: "MCA")
      get "/qualification/#{qualification.id}"
    end

    it "returns an error message if specified qualification not found" do
      get "/qualification/invalid_id"
    end
  end
end
