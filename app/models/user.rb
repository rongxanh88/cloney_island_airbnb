require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /^image\/(png|jpeg|jpg)/

  validates :first_name, :last_name, :phone_number, :email, :birthday, presence: true
  validates :email, :phone_number, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  has_many :listings
  has_many :user_roles
  has_many :roles, through: :user_roles

  def full_name
    first_name + " " + last_name
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def host?
    roles.exists?(name: "host")
  end

  def traveler?
    roles.exists?(name: "traveler")
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name
      user.last_name = auth.info.name
      user.phone_number = auth.phone_number
      user.birthday = auth.birthday
      user.password = SecureRandom.urlsafe_base64
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      binding.pry
      user.save!
    end
  end
end
