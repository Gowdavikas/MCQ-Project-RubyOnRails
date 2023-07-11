class Users::SessionsController < Devise::SessionsController

  respond_to :json

  
  def respond_with(user, _opts = {})
    if user.valid_password?(params[:user][:password]) && user.otp_verified == true
      sign_in user
      render json: {
        Message: "Logged in successfully."
      }, status: :ok
    else
      render json: {
        message: "Failed to login. Please make sure your OTP is verified and provide correct credentials."
      }, status: 401
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['token'],Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        message: "User logged out successfully"
      }, status: 200
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
