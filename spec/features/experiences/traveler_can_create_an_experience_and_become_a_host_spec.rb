require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'As a traveler' do
  include ExperienceHelper

  before(:example) do
    @user = create(:user)
    host_role
  end

  describe 'can create a new experience' do

    it 'adds host to user roles' do
      listing = create(:listing)
      listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_experience_path

      fill_in "Title", :with => "Visit the Only Worthy Gallery in the Galaxy"
      fill_in "Duration", :with => "2 hours"
      fill_in "Tagline", :with => "If you're with us, you're awesome!"
      fill_in "experience[what]", :with => "Walk around and ask questions about art. Do you buy art because it's evocative? Would you buy art that disgusts you becaues it evokes that feeling?"
      fill_in "Where", :with => "The place beyond the pines."
      fill_in "experience[provisions]", :with => "Water, energy bars, chewing gum."
      fill_in "Notes", :with => "Bring yourself. Bring your smile. Bring your happiness and share it."
      fill_in "Group Size", :with => "10"
      fill_in "Guest Requirements", :with => "Smile a lot."
      fill_in "Cancellation Policy Type", :with => "Moderate"
      fill_in "Price", :with => "$29"
      fill_in "Host Description", :with => "I ran out of time on this project."
      fill_in "Street Address", :with => "123 Go"
      fill_in "City", :with => "Denver"
      fill_in "State", :with => "CO"
      fill_in "Zipcode", :with => "90210"

      click_on "Create Your Experience"

      expect(@user.roles.first.name).to eq("host")
    end
  end
end
