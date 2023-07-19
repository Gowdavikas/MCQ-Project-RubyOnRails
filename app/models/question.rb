class Question < ApplicationRecord
    has_many :answer
    has_many :options, dependent: :destroy
    validates :question, presence: true
    validates :level, inclusion: { in: ['level_1', 'level_2', 'level_3'], message: "Level cannot be empty" }
    validates :codeLanguage, inclusion: { in: ['React-native', 'React-Js', 'Java-full-stack', 'Ruby'], message: "Code language cannot be empty" }
    accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
end