require 'rails_helper'

RSpec.feature "Guest can search properties", type: :feature do
  scenario "guests can search by city" do
    VCR.use_cassette('features/user_can_search_with_city') do
      address = "123 Fake St. Boulder, CO 80111"

      visit root_path

      within(".search") do
        expect(page).to have_field("search_address")
        expect(page).to have_selector(:link_or_button, 'Search')
      end

      fill_in "search_address", with: "boulder"
      click_on "Search"

      expect(current_path).to eq(listings_path)
      expect(page).to have_content('beds')
      expect(page).not_to have_content("Bad Listing")
    end
  end
end
