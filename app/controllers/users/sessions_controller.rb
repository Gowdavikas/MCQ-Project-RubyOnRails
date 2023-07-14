class Users::SessionsController < Devise::SessionsController

  respond_to :json
  
  
  def respond_with(user, _opts = {})
    if user.valid_password?(params[:user][:password]) && user.academic.present? && user.otp_verified == true 
      sign_in user
      render json: {
        Message: "#{user.role} #{user.name} Logged in successfully."
      }, status: :ok
    else
      render json: {
        message: "Failed to login. Please make sure your OTP is verified and Academic-form is filled and provide correct credentials."
      }, status: 401
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        message: "User #{current_user.name} logged out successfully"
      }, status: 200
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
