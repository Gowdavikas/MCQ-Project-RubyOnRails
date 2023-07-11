class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :question
  has_one :academics


    enum role: { admin: "admin", user: "user", teacher: "teacher"}
    before_validation :set_default_role

    private
    def set_default_role
      self.role ||= "user"
    end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  def jwt_payload
    super
  end

  

  validates :role, presence: true
end
