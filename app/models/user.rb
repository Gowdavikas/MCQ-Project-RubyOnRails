class User < ApplicationRecord
  has_many :questions
  has_one :academic
  


  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  def jwt_payload
    super
  end

    enum role: { admin: "admin", user: "user", teacher: "teacher"}
    before_validation :set_default_role
    validates :role, presence: true
    validates :name, presence: true

    # def 

  private
    def set_default_role
      self.role ||= "user"
    end
end
