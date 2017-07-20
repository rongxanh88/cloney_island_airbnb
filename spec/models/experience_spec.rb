require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe 'attributes' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:tagline)}
    it {should validate_presence_of(:what)}
    it {should validate_presence_of(:where)}
    it {should validate_presence_of(:provisions)}
    it {should validate_presence_of(:notes)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:host_description)}
    it {should validate_presence_of(:group_size)}
    it {should validate_presence_of(:guest_requirements)}
    it {should validate_presence_of(:cancellation_policy_type)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}

    it {should validate_presence_of(:user_id)}

    # it {should validate_presence_of(:experience_images)}
    # it {should validate_presence_of(:experience_dates)}
  end

  describe 'relationships' do
    it {should have_many(:experience_categories)}
    # it {should have_many(:experience_dates)}
    # it {should have_many(:experience_images)}
  end


end
