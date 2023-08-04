require 'twilio-ruby'

module Twilio

  class SmsService

    def initialize(to:, pin:)
      @to = to
      @pin = pin
    end

    def call
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      service_id = ENV['TWILIO_SERVICE_ID']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      verifications = @client.verify
                            .v2
                            .services(service_id)
                            .verifications
                            .create(to: @to, channel: 'sms')
    end


    def verify_passcode
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      service_id = ENV['TWILIO_SERVICE_ID']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      verification_check = @client.verify
                                  .v2
                                  .services(service_id)
                                  .verification_checks
                                  .create(to: @to, code: @pin)
      return { status: verification_check.status }
    end
  end
end