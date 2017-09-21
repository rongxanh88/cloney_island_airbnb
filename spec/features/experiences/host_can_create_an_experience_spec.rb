require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'As a host' do
  include ExperienceHelper
  describe 'a host can create a new experience' do

    before(:example) do
      @exp = create_experience
      @user = @exp.user
    end

    it 'can create a new listing' do
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
    end
  end
end
