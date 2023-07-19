class Option < ApplicationRecord
  belongs_to :question
  validates :option, presence: true
end
