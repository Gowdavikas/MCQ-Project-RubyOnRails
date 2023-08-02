require "rails_helper"

RSpec.describe McqmailerMailer, type: :mailer do

  describe "email" do
    user = User.create(name: "vikas", role: "user", phonenumber: "95913301819", email: "valid_user@gmail.com", password: "12345678")
    score = 50

    it "sends the email to the user" do
      email = McqmailerMailer.email(user, score).deliver_now
      expect(email.to).to eq([user.email])
    end

    it "has the correct subject" do
      email = McqmailerMailer.email(user, score).deliver_now
      expect(email.subject).to eq('Regarding your MCQ-Test result')
    end

    it 'contains the user name and score in the body' do
      email = McqmailerMailer.email(user, score).deliver_now
      expect(email.body).to include("Hello, #{user.name}!\nYour MCQ test score: #{score}")
    end
  end
end
