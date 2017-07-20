require 'rails_helper'

RSpec.feature "Host can view their reservations", type: :feature do
  scenario "host visits host dashboard" do
    role = create(:role, name: 'host')
    role2 = create(:role, name: 'traveler')
    host = create(:user, first_name: 'Host Name')
    host.roles << role
    other_host = create(:user, first_name: 'Other Host')
    other_host.roles << role

    listing = create(:listing, user_id: host.id)

    traveler = create(:user, first_name: 'Traveler name')
    traveler.roles << role2
    another_traveler = create(:user, first_name: 'Another Traveler')
    another_traveler.roles << role2

    trip1 = create(:trip, host_id: host.id, user_id: traveler.id)
    trip2 = create(:trip, host_id: host.id, listing_id: listing.id, user_id: another_traveler.id)
    trip3 = create(:trip, host_id: other_host.id, user_id: traveler.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit host_dashboard_index_path(host)

    expect(page).to have_content 'All Reservations'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Dates and Locations'
    expect(page).to have_content 'Guest'
    expect(page).to have_content 'Details'

    expect(page).to have_selector(".trip", count: 2)

    expect(page).to have_content listing.address
    expect(page).to have_content listing.name
    expect(page).to have_content trip1.trip_status
    expect(page).to have_content trip1.start_date
    expect(page).to have_content trip1.end_date
    expect(page).to have_content traveler.first_name
    expect(page).to have_content trip2.trip_status
    expect(page).to have_content trip2.start_date
    expect(page).to have_content trip2.end_date
    expect(page).to have_content another_traveler.first_name

    expect(page).to have_content 'Message History'
  end
end
