class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.valid?
      resource.save
      Twilio::SmsService.new(to: resource.phonenumber, pin: '').call
      sign_up(resource_name, resource)
      token = request.env['warden-jwt_auth.token']
      render json: {
        message: "Signed Up Successfully",
        user: resource.as_json(only: [:id, :name, :email, :role]),
        token: token
      }, status: 200
    else
      render json: {
        message: resource.errors.full_messages
      }, status: 422
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: 400
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :name, :password, :role, :phonenumber)
  end
end