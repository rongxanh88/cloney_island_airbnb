class ExperienceCategory < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :exp_experience_categories
  has_many :experiences, through: :exp_experience_categories

end
