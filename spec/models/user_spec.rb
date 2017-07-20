require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:phone_number)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}

    it { should allow_value("email@address.com").for(:email) }
    it { should_not allow_value("dude").for(:email) }

    it {should validate_uniqueness_of(:email)}
    it {should validate_uniqueness_of(:phone_number)}

    it { should have_attached_file(:profile_picture) }
    it { should validate_attachment_content_type(:profile_picture).
                allowing('image/png', 'image/jpeg', 'image/jpg').
                rejecting('text/plain', 'text/xml', 'image/gif') }
  end

  describe 'relationships' do
    it {should have_many(:user_roles)}
    it {should have_many(:roles).through(:user_roles)}
    it {should have_many(:listings)}
    it {should have_many(:messages)}
    it {should have_many(:conversations).through(:messages)}
  end

  describe 'password' do
    it {should have_secure_password}
  end

  describe 'user methods' do
    it 'can create full name' do
      user = create(:user)
      full_name = user.full_name

      expect(full_name).to eq(user.first_name + " " + user.last_name)
    end

    it 'check for host role' do
      role = create(:role, name: "host")
      user = create(:user)
      other_user = create(:user)
      user.roles << role

      expect(user.host?).to be(true)
      expect(other_user.host?).to be(false)
    end

    it 'check for traveler role' do
      role = create(:role, name: "traveler")
      user = create(:user)
      other_user = create(:user)
      user.roles << role

      expect(user.traveler?).to be(true)
      expect(other_user.traveler?).to be(false)
    end
  end


end
