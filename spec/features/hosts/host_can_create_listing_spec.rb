require 'rails_helper'

RSpec.feature "Host can do the following with listings", type: :feature do
  scenario "create a new listing" do
    host_role = create(:role, name: 'host')
    traveler_role = create(:role)
    host = create(:user)
    host.roles << [host_role, traveler_role]

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit new_user_host_listing_path(host)

    within ".new_listing_container" do
      fill_in "Name", with: "Awesome Room in Treehouse of Horror"
      fill_in "Description", with: "No One Lives Here Permanently!"
      fill_in "Address", with: "1234 Death Row Denver, CO, 80202"
      fill_in "Accomodates", with: 1
      fill_in "Bathrooms", with: 1
      fill_in "Bedrooms", with: 1
      fill_in "Beds", with: 1
      fill_in "Price", with: 21.99
      select "House", from: "host_property_type"
      select "King", from: "host_bed_type"
      select "Entire Home", from: "host_room_type"
      select "No Pets", from: "host_pet_type"
      select "Flexible", from: "host_cancellation_policy"

      click_on "Create"
    end
    listing = Listing.first
    expect(page).to have_current_path(listing_path(listing))
  end

  scenario 'host can edit listing' do
    host_role = create(:role, name: 'host')
    traveler_role = create(:role)
    host = create(:user)
    host.roles << [host_role, traveler_role]
    listing = create(:listing, user_id: host.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit edit_user_host_listing_path(host, listing)

    within ".new_listing_container" do
      fill_in "Name", with: "Awesome Room in Treehouse of Horror"
      fill_in "Description", with: "No One Lives Here Permanently!"
      fill_in "Address", with: "1234 Death Row Denver, CO, 80202"
      fill_in "Accomodates", with: 1
      fill_in "Bathrooms", with: 1
      fill_in "Bedrooms", with: 1
      fill_in "Beds", with: 1
      fill_in "Price", with: 21.99
      select "House", from: "host_property_type"
      select "King", from: "host_bed_type"
      select "Entire Home", from: "host_room_type"
      select "No Pets", from: "host_pet_type"
      select "Flexible", from: "host_cancellation_policy"

      click_on "Update"
    end

    expect(page).to have_current_path(user_host_listing_path(host, listing))
  end
end
