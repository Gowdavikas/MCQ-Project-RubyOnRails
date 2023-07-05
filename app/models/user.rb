class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher


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

  has_many :question

  validates :role, presence: true
end
