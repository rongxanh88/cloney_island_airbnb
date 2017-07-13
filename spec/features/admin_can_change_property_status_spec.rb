require 'rails_helper'

RSpec.feature "Host can change property status", type: :feature do
  scenario "change status from unlisted to listed" do
    role = create(:role, name: 'host')
    host = create(:user)
    host.roles << role

    listing = create(:listing)
    listing.user = host
    # role = Role.create!(name: "host")
    # host = User.create!(
    # birthday: Faker::Date.birthday(18, 97),
    # first_name: Faker::Name.first_name,
    # last_name: Faker::Name.last_name,
    # phone_number: "#{Faker::PhoneNumber.area_code} - #{Faker::PhoneNumber.exchange_code} - #{Faker::PhoneNumber.unique.subscriber_number}",
    # email:  Faker::Internet.unique.email,
    # password: "password",
    # profile_picture: "http://lorempixel.com/400/300/city"
    # )
    # listing = Listing.create!(
    #   description: "Suite of three beautifully furnished rooms set amongst the trees. Just minutes from downtown, this secluded property is an urban retreat like no other. The treehouse provides and intimate, simple and calming retreat for 2 people. The treehouse is the subject of innumerable articles, blogs and was recently featured on Treehouse Masters Ultimate Treehouses.",
    # address_id: host.addresses.first.id,
    # user_id: host.id,
    # property_type: [0, 1, 2, 3, 4].sample,
    # room_type: [0, 1, 2].sample,
    # bed_type: [0, 1, 2, 3, 4, 5].sample,
    # accomodates: [1, 2, 3, 4, 5, 6].sample,
    # bathrooms: [1, 2, 3, 4, 5, 6].sample,
    # name: "Home of #{Faker::Ancient.god} #{host.id}",
    # bedrooms: [1, 2, 3, 4, 5, 6].sample,
    # beds: [1, 2, 3, 4, 5, 6].sample,
    # pet_type: [0, 1, 2, 3, 4].sample,
    # price: [100, 200, 300, 400, 500, 600].sample,
    # house_rules: ["No Smoking", "No Teenagers", "Hippies Use Back Door"].sample,
    # cancellation_id: [1, 2, 3].sample,
    # status: ["unlisted", "listed"].sample
    # )
    # user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit host_dashboard_path(host)
    click_on "View All Properties"

    expect(current_path).to eq(host_properties_path)

    within(".pending_properties") do
      expect(page).to have_content(listing.name)
      click_on "Activate"
    end

    expect(listing.status).to eq(1)
  end

  xit "traveler cannot change listing status" do
    user = create(:user)
    role = create(:role, name: 'traveler')


  end

  xit "traveler cannot see an unlisted listing" do
    user = create(:user)
    role = create(:role, name: 'traveler')


  end
end
