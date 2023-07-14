class Academic < ApplicationRecord
  belongs_to :interest
  belongs_to :qualification
  belongs_to :user

  has_one_attached :cv
  has_one_attached :govt_id

  validates :user_id, uniqueness: { message: "User already has an academic record" }

end
