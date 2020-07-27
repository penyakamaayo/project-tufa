class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # dili case sensitive ang username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # para dili maka fill up ug email sa 'Username' na field
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  # :database_authenticatable,
  devise :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :two_factor_authenticatable,
         authentication_keys: [:login], :otp_secret_encryption_key => ENV['test_key']

  attr_writer :login
  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
