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
  has_many :addresses

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
end
