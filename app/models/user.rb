class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation
  
  validates :email,     presence: true,
                        uniqueness: true,
                        email: true
  validates :username,  presence: true,
                        uniqueness: true
  validates :password,  length: { minimum: 8 },
                        allow_blank: true
  
  def self.find_by_login(login)
    self.find_by_username(login) || self.find_by_email(login) 
  end
end
