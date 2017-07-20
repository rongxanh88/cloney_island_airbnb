class ExperienceImage < ApplicationRecord
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /^image\/(png|jpeg|jpg)/

  belongs_to :experience
end
