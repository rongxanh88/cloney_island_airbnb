require 'rails_helper'

RSpec.feature "Host can change property status", type: :feature do
  scenario "change status from unlisted to listed" do
    skip
    role = create(:role, name: 'host')
    host = create(:user)
    host.roles << role

    listing = create(:listing)
    listing.user = host

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit host_dashboard_index_path(host)
    save_and_open_page
    click_on "View All Properties"

    expect(current_path).to eq(host_properties_path)

    within(".pending_properties") do
      expect(page).to have_content(listing.name)
      click_on "Activate"
    end

    expect(listing.status).to eq(1)
  end

  xit "traveler cannot change listing status" do
    traveler = create(:user)
    role = create(:role, name: 'traveler')


  end

  xit "traveler cannot see an unlisted listing" do
    user = create(:user)
    role = create(:role, name: 'traveler')


  end
end
