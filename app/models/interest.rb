class Interest < ApplicationRecord
    has_one :academic, dependent: :destroy
    validates :name, presence: true
end
