require 'rails_helper'

RSpec.describe "Rendering pins on map" do
  scenario 'user can see features house pins on map when visiting home page' do
    listing = create(:listing)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit root_path

    expect(page).to have_css('div#map')
  end
end
