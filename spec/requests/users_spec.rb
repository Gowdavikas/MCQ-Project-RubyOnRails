require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /index" do
    it "returns list of all users" do
      user = User.create(name: "Vikas gowda",role: "user",phonenumber: "95913301819",email: "vikasgowda@gmail.com",password:"12345678")
      get "/users"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET / show" do
    it "returns a specified user details" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "95913301819",email: "vikas@gmail.com",password:"12345678")
      get "/user/1"
      expect(response).to have_http_status(200)
    end

    it " returns an error message if specified user details not found" do
      get "/user/invali_id"
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT / update" do
    it "updates the details of a specific user" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "+919591030953",email: "vikas@gmail.com",password:"12345678")
      params = {name: "Vikas Gowda",role: "user",phonenumber: "+919591030953",email: "vikas@gmail.com",password:"12345678"}
      put "/user/1", params: {user: params}
      expect(response).to have_http_status(200)
    end

    it "returns an error message, when fails to update specified user record" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "+919591030953",email: "vikas@gmail.com",password:"12345678")
      params = {name: "",role: "user",phonenumber: "+919591030953",email: "vikas@gmail.com",password:"12345678"}
      put "/user/1", params: {user: params}
      expect(response).to have_http_status(400)
    end
  end

  describe "DESTROY /delete" do
    it "Deletes a specific user" do
      user = User.create(name: "sdfghj",role: "admin",phonenumber: "+919591030953",email: "dfghj@gmail.com",password:"12345678")
      delete "/user/#{user.id}"
      expect(response).to have_http_status(200)
    end

    it "returns an error message, when fails to delete specified user record" do
      user = User.create(name: "Vikas",role: "admin",phonenumber: "+919591030953",email: "vikas@gmail.com",password:"12345678")
      delete "/user/invalid_id"
      expect(response).to have_http_status(400)
    end
  end
end
