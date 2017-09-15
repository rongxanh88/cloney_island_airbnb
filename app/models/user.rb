require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /^image\/(png|jpeg|jpg)/

  validates :first_name, :last_name, :phone_number, :email, :birthday, presence: true
  validates :email, :phone_number, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  has_many :listings, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :messages
  has_many :conversations, through: :messages
  has_many :trips, dependent: :destroy
  has_many :experiences

  def full_name
    first_name + " " + last_name
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
      user.email = auth.info.email
      user.phone_number = "505-234-9092"
      user.birthday = Date.new
      user.password = SecureRandom.urlsafe_base64
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
