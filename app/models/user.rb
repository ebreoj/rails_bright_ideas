class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :alias, :email, presence: true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save :email_downcase

  def email_downcase
    email.downcase!
  end
end
