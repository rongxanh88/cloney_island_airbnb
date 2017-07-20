class Experience < ApplicationRecord
  validates :title, :duration, :tagline, :what, :where, :provisions, :notes, :price, :host_description, :group_size, :guest_requirements, :cancellation_policy_type, :street_address, :city, :state, :zipcode, :user_id, presence: true

  belongs_to :user
  has_many :experience_images, dependent: :destroy
  has_many :exp_experience_categories, dependent: :destroy
  has_many :experience_categories, through: :exp_experience_categories
end
