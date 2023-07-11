class Users::RegistrationsController < Devise::RegistrationsController

  skip_before_action :verify_authenticity_token
  
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      Twilio::SmsService.new(to: resource.phonenumber, pin: '').call
      sign_up(resource_name, resource)
      token = request.env['warden-jwt_auth.token']
      render json:{
        message: "Signed Up Successfully",
        user: resource.as_json(only: [:id, :name, :email, :role]),
        token: token
      }, status: 200
    else
      render json: {
        message: resource.errors.full_messages
      }, status: 422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :name, :password, :role, :phonenumber)
  end
end
