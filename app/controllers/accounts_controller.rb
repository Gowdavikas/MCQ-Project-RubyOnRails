class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def otp_verify
        sms_service = Twilio::SmsService.new(to: current_user.phonenumber, pin: verification_params[:pin])
        verification_check = sms_service.verify_passcode
        if verification_check == {:status=> "approved"}
          current_user.update(otp_verified: true)
          render json: verification_check
        end
    end
  
    private
  
    def verification_params
      params.require(:verify).permit(:pin)
    end
end