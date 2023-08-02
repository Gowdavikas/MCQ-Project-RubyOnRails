require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe "associations" do
    it "belongs to an user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to an question" do
      association = described_class.reflect_on_association(:question)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "validates uniqueness of userAnswer" do
      user = User.create(name: "Jackie", role: "admin", phonenumber: "95913301819", email: "jackieson@gmail.com", password: "12345678")
      question = Question.create(question: "What is rspec in ruby?", level: "level_1", codeLanguage: "Ruby")
      existing_answer = Answer.create(correctAnswer: "devise", userAnswer: "devise", expectedResult: true, user_id: user.id, question_id: question.id)
      new_answer = Answer.create(correctAnswer: "rspec", userAnswer: "devise", expectedResult: false, user_id: user.id, question_id: question.id)
      expect(new_answer).not_to be_valid
    end
  end
end