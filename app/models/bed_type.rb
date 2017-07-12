class BedType < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :listings
end