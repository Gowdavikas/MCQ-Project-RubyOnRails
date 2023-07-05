class Question < ApplicationRecord
    has_many :answer
    has_many :option
end
