require 'rails_helper'

RSpec.describe QualificationsController, type: :request do
  describe "GET /index" do
    before do
      Qualification.destroy_all
    end
    it "returns a list of qualification details" do
      qualification = Qualification.create(name: "BCA")
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

  describe "POST /create" do
    it "create new qualification record" do
      qualification_params = {name: "Artificial intelligence"}
      post "/qualification", params: {qualification: qualification_params}
      expect(response).to have_http_status(201)
    end

    it "returns an error message if it fails to create new record" do
      qualification_params = {name: ""}
      post "/qualification", params: {qualification: qualification_params}
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT /update" do
    it "updates the specified record" do
      qualification = Qualification.create(name: "MCA")
      qualification_params = {name: "BE(cse)"}
      put "/qualification/#{qualification.id}", params: {qualification: qualification_params}
      expect(response).to have_http_status(200)
    end

    it "returns an error message if it fails to update specified record" do
      qualification = Qualification.create(name: "MCA")
      qualification_params = {name: ""}
      put "/qualification/#{qualification.id}", params: {qualification: qualification_params}
      expect(response).to have_http_status(400)
    end
  end

  describe "DESTROY /delete" do
    it "deletes the specified record" do
      qualification = Qualification.create(name: "Ms(cse)")
      delete "/qualification/#{qualification.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message if it fails to delete a specified record" do
      delete "/qualification/invalid_id"
      expect(response).to have_http_status(400)
    end
  end
end
