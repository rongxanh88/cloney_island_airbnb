require 'rails_helper'

RSpec.describe ExperienceCategory, type: :model do

  describe 'attributes' do
    it {should validate_presence_of(:name)}
  end

  describe 'relationships' do
    it {should have_many(:exp_experience_categories)}
    it {should have_many(:experiences).through(:exp_experience_categories)}
  end
  
end
