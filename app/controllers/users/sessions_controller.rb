class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: :destroy
  before_action :verify_signed_out_user, only: :destroy

  respond_to :json
  
  
  def respond_with(user, _opts = {})
    if user.valid_password?(params[:user][:password]) && user.academic_status == true && user.otp_verified == true && user.logged_out_once == true
      token = request.env['warden-jwt_auth.token']
      sign_in user
      user.update(logged_out_once: false)
      render json: {
        Message: "Logged in successfully.",
        Name: user.name,
        Role: user.role,
        token: token
      }, status: 200
    else
      render json: {
        message: "Failed to login. User may already logged in OR Please make sure your OTP is verified."
      }, status: 401
    end
  end

  def destroy
    token = request.headers['token']&.split&.last
  
    if token.blank?
      render json: { message: 'Token not provided' }, status: :unprocessable_entity
      return
    end
  
    begin
      decoded_token = JWT.decode(token, nil, false)
      payload = decoded_token.first
  
      if payload.present? && payload['exp'] >= Time.now.to_i
        user = User.find_by(id: payload['sub'])
  
        if user.present? && !user.logged_out_once?
          sign_out user
          user.update(logged_out_once: true)
          # request.env['warden-jwt_auth.token'] = nil
          render json: { message: "Name: #{user.name}, Logged out successfully" }, status: 200
        else
          render json: { message: 'User already logged out once, please login-in again' }, status: 400
        end
      end
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT Decode Error: #{e.message}")
      render json: { message: 'Invalid token' }, status: 400
    end
  end

  private

  def verify_signed_out_user
    return unless user_signed_in?
    render json: { message: 'You are already signed in. Please sign out first.' }, status: :unprocessable_entity
  end
end
