class Listing < ApplicationRecord
  validates :airbnb_id, presence: true
  has_many :trips
  belongs_to :user, optional: true

  has_many :listing_images, dependent: :destroy
  has_many :listing_amenities, dependent: :destroy
  has_many :amenities, through: :listing_amenities
  has_many :trips

  enum property_type: [:house, :apartment, :guesthouse, :boat, :treehouse]
  enum room_type: [:entire_home, :private_room, :shared_room]
  enum bed_type: [:king, :queen, :double, :twin, :single, :couch]
  enum pet_type: [:no_pets, :cat, :dog, :cat_and_dog, :misc]
  enum status: [:unlisted, :listed]
  enum cancellation_policy: [:flexible, :moderate, :strict]

  accepts_nested_attributes_for :listing_images, :reject_if => lambda { |t| t['listing_image'].nil? }

  scope :listed, -> { where(status: 1) }
end
