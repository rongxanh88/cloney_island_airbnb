require 'rails_helper'

RSpec.describe 'As a traveler' do
  scenario 'I can book a listing from the search results' do
    traveler_role = create(:role)
    traveler = create(:user)
    traveler.roles << traveler_role
    listing = create(:listing, status: 'listed')
    create(:listing_image, listing_id: listing.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)

    visit "/listings/#{listing.id}"

    expect(page).to have_content listing.name
    expect(page).to have_content listing.accomodates
    expect(page).to have_content listing.beds

    user_trips_count = traveler.trips.count

    click_button 'Book Now'

    expect(current_path).to eq("/listings/#{listing.id}/trips/new")
    expect(page).to have_content 'Confirm Your Booking'

    fill_in 'Start Date', with: '2017/08/08'
    fill_in 'End Date', with: '2017/08/12'
    fill_in 'Guests', with: 3
    click_button 'Confirm Booking'

    expect(current_path).to eq("/trips")

    user_new_trips_count = traveler.trips.count
    expect(user_new_trips_count).to be > user_trips_count

    expect(page).to have_content traveler.trips.first.start_date
    expect(page).to have_content traveler.trips.last.start_date
    expect(page).to have_content traveler.trips.first.end_date
    expect(page).to have_content traveler.trips.last.end_date
    expect(page).to have_content traveler.trips.first.listing.name
    expect(page).to have_content listing.name
    expect(page).to have_content listing.address
    expect(page).to have_content listing.user.first_name
    expect(page).to have_content listing.user.phone_number
    expect(page).to have_content listing.user.email
  end

  # scenario 'I can book a listing from the featured listings on the homepage' do
  #   traveler_role = create(:role)
  #   traveler = create(:user)
  #   traveler.roles << traveler_role
  #   listing = create(:listing, status: 'listed')
  #   create(:listing_image, listing_id: listing.id)
  #
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
  #
  #   visit "/"
  #
  #   expect(page).to have_content listing.name
  #   expect(page).to have_content listing.beds
  #
  #   user_trips_count = traveler.trips.count
  #
  #   find(:xpath, "//a[@href='/experiences/#{traveler.id}']").click
  #
  #   click_button 'Book Now'
  #
  #   expect(current_path).to eq("/listings/#{listing.id}/trips/new")
  #   expect(page).to have_content 'Confirm Your Booking'
  #
  #   fill_in 'Start Date', with: '2017/08/08'
  #   fill_in 'End Date', with: '2017/08/12'
  #   fill_in 'Guests', with: 3
  #   click_button 'Confirm Booking'
  #
  #   expect(current_path).to eq("/trips")
  #
  #   user_new_trips_count = traveler.trips.count
  #   expect(user_new_trips_count).to be > user_trips_count
  #
  #   expect(page).to have_content traveler.trips.first.start_date
  #   expect(page).to have_content traveler.trips.last.start_date
  #   expect(page).to have_content traveler.trips.first.end_date
  #   expect(page).to have_content traveler.trips.last.end_date
  #   expect(page).to have_content traveler.trips.first.listing.name
  #   expect(page).to have_content listing.name
  #   expect(page).to have_content listing.address
  #   expect(page).to have_content listing.user.first_name
  #   expect(page).to have_content listing.user.phone_number
  #   expect(page).to have_content listing.user.email
  # end
end
