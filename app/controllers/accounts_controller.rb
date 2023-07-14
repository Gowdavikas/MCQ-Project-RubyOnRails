class AccountsController < ApplicationController
  def otp_verify
    begin
      jwt_payload = JWT.decode(request.headers['token'], Rails.application.credentials.fetch(:secret_key_base)).first
      current_user = User.find(jwt_payload['sub'])
      sms_service = Twilio::SmsService.new(to: current_user.phonenumber, pin: verification_params[:pin])
      verification_check = sms_service.verify_passcode

      if verification_check == { status: "approved" }
        current_user.update(otp_verified: true)
        render json: verification_check
      else
        render json: { error: "Invalid token or PIN" }, status: :bad_request
      end

    rescue Twilio::REST::RestError => e
      Rails.logger.error("Twilio Error: #{e.message}")
      render json: { error: "Token is not matching with the pin" }, status: 400
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT Decode Error: #{e.message}")

      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end

  private

  def verification_params
    params.permit(:pin)
  end
end
