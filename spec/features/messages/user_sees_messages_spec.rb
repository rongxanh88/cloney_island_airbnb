require 'rails_helper'

RSpec.describe "On Messages Show Page" do

  it "once a traveler requests to book, a conversation begins" do
    User.destroy_all
    traveler = create(:user)
    role = create(:role, name: "host")
    host = create(:user)
    host.roles << role
    listing = create(:listing, user_id: host.id)

    new_conversation = traveler.trips
    expect(traveler.trips).to eq([])

    visit listing_path(listing)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)

    click_on "Book Now"

    fill_in "Start Date", with: "#{Date.today + 3}"
    fill_in "End Date", with: "#{Date.today + 5}"
    fill_in "Guests", with: 3

    click_on "Confirm Booking"

    expect(listing.trips.first.conversation.created_at.to_date).to eq(Time.now.utc.to_date)
  end

  it "hosts can read traveler messages" do
    host = create(:user)
    traveler = create(:user)
    role = create(:role)
    host_role = create(:role, name: 'host')
    traveler.roles << role
    listing = create(:listing, user_id: host.id)
    trip = create(:trip, host_id: host.id, user_id: traveler.id, listing_id: listing.id)
    conversation = Conversation.create!(trip_id: trip.id)
    message = Message.create!(content: 'test message', user_id: traveler.id, conversation_id: conversation.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    conversation = trip.conversation
    latest_message = conversation.messages.last

    visit conversation_path(conversation)

    expect(page).to have_content(latest_message.content)
  end

  it "hosts can send traveler messages" do
    host = create(:user)
    traveler = create(:user)
    role = create(:role)
    host_role = create(:role, name: 'host')
    traveler.roles << role
    listing = create(:listing, user_id: host.id)
    trip = create(:trip, host_id: host.id, user_id: traveler.id, listing_id: listing.id)
    conversation = Conversation.create!(trip_id: trip.id)
    message = Message.create!(content: 'test message', user_id: traveler.id, conversation_id: conversation.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    latest_message = conversation.messages.last

    visit conversation_path(conversation)

    fill_in 'message[content]', with: "Hey that sounds great!"
    click_button "Send Message"

    expect(host.messages.last.content).to eq("Hey that sounds great!")
  end
end
