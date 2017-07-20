require 'rails_helper'

RSpec.feature "Guest can search properties", type: :feature do
  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  
  scenario "guests can search by city" do
    address = "123 Fake St. Boulder, CO 80111"
    5.times do |n|
      listing = create(:listing, status: 1, address: "Bad address Rd Denver, CO 80303", name: "Bad Listing #{n}")
      listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))
    end
    result = create(:listing, status: 1, address: address, name: "Good Listing")
    result.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit root_path

    within(".search") do
      expect(page).to have_field("search_address")
      expect(page).to have_selector(:link_or_button, 'Search')
    end

    fill_in "search_address", with: "ouLDe"
    click_on "Search"

    expect(page).to have_content(result.name)
    expect(page).not_to have_content("Bad Listing")
  end

  scenario "guests can search by zip_code" do
    address = "123 Fake St. Boulder, CO 80111"
    5.times do |n|
      listing = create(:listing, status: 1, address: "Bad address Rd Denver, CO 80303", name: "Bad Listing #{n}")
      listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))
    end
    result = create(:listing, status: 1, address: address, name: "Good Listing")
    result.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit root_path

    within(".search") do
      expect(page).to have_field("search_address")
      expect(page).to have_selector(:link_or_button, 'Search')
    end

    fill_in "search_address", with: "8011"
    click_on "Search"

    expect(page).to have_content(result.name)
    expect(page).not_to have_content("Bad Listing")
  end

  scenario "guest can search by dates" do
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)

    user = create(:user)
    host = create(:user)
    trip = Trip.create!(user_id: user.id,
    host_id: host.id,
    trip_status: 0,
    num_guests: 3,
    start_date: Date.today,
    end_date: Date.tomorrow,
    listing_id: listing.id)

    visit root_path

    fill_in "search_start_date", with: "#{Date.today + 3}"
    fill_in "search_end_date", with: "#{Date.today + 5}"
    click_on "Search"

    expect(current_path).to_not have_content(listing.name)
  end

  scenario "guest can search by dates sad path" do
    listing = create(:listing, status: 1)
    create(:listing_image, listing_id: listing.id)

    user = create(:user)
    host = create(:user)
    trip = Trip.create!(user_id: user.id,
    host_id: host.id,
    trip_status: 0,
    num_guests: 3,
    start_date: Date.today,
    end_date: Date.tomorrow,
    listing_id: listing.id)

    visit root_path

    fill_in "search_start_date", with: "#{Date.today}"
    fill_in "search_end_date", with: "#{Date.tomorrow}"
    click_on "Search"

    expect(current_path).to_not have_content(listing.name)
  end

  scenario "guests can search by number of accomodations" do
    listing = create(:listing, accomodates: 4, status: 1, address: "Boulder, CO 80303")
    listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit root_path

    fill_in "search_address", with: "Boulder"
    fill_in "search_num_guests", with: 3
    click_on "Search"

    expect(page).to have_content(listing.name)
  end

  scenario "guests can search by number of accomodations sad path" do
    listing = create(:listing, accomodates: 4, status: 1, address: "Boulder, CO 80303")
    listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit root_path

    fill_in "search_address", with: "#{listing.address}"
    fill_in "search_num_guests", with: 5
    click_on "Search"

    expect(current_path).to eq(listings_path)
  end
end
