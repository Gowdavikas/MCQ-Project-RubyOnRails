class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def otp_verify
        jwt_payload = JWT.decode(request.headers['token'], Rails.application.credentials.fetch(:secret_key_base)).first
        current_user = User.find(jwt_payload['sub'])
        sms_service = Twilio::SmsService.new(to: current_user.phonenumber, pin: verification_params[:pin])
        verification_check = sms_service.verify_passcode
        render json: verification_check
    end
  
    private
  
    def verification_params
      params.require(:verify).permit(:pin)
    end
end