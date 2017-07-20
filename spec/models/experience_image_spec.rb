require 'rails_helper'

RSpec.describe ExperienceImage, type: :model do
  it {should belong_to(:experience)}
  it {should have_attached_file(:image)}
  it {should validate_attachment_content_type(:image)}
end
