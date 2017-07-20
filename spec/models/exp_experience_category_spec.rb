require 'rails_helper'

RSpec.describe ExpExperienceCategory, type: :model do

  describe 'relationships' do
    it {should belong_to(:experience)}
    it {should belong_to(:experience_category)}
  end
  
end
