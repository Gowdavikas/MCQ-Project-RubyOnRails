require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:question) }
  end

  describe 'validations' do
    subject { described_class.new }

    it { should validate_uniqueness_of(:userAnswer) }
    it { should validate_uniqueness_of(:question_id) }
  end
end
