require 'rails_helper'

RSpec.describe 'As a guest user' do
  it 'can create visit homepage, view listings, go to sign up page' do
    role = create(:role, name: 'traveler')
    traveler = create(:user)
    traveler.roles << role

    listing = create(:listing)
    listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit ('/')

    expect(current_path).to eq("/")

    expect(page).to have_content(listing.name)

      click_on "Sign Up"

    expect(current_path).to eq('/users/new')

  end
end
