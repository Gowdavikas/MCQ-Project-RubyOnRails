require 'twilio-ruby'

module Twilio

    TWILIO_ACCOUNT_SID = 'AC0776dff6c722e0690743126300bfa324'
    TWILIO_AUTH_TOKEN = '90516ccc26a0fdbe2c32e9e968926ba4'
    TWILIO_SERVICE_ID = 'VA65b1bfe56bdb6aed13dacab81c8a444f'
    TWILIO_FROM_PHONE = '+18148014239'

  class SmsService

    def initialize(to:, pin:)
      @to = to
      @pin = pin
    end

    def call
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
      verification = @client.verify
                            .v2
                            .services(TWILIO_SERVICE_ID)
                            .verifications
                            .create(to: @to, channel: 'sms')
    end


    def verify_passcode
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
      verification_check = @client.verify
                                  .v2
                                  .services(TWILIO_SERVICE_ID)
                                  .verification_checks
                                  .create(to: @to, code: @pin)
      return { status: verification_check.status }
    end
  end
end