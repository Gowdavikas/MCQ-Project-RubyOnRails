class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :userAnswer, uniqueness: true
  validates :question_id, uniqueness: true
end
