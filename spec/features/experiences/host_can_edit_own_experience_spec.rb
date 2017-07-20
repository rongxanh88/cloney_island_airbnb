require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'As a host with experiences' do
  include ExperienceHelper

  before(:example) do
    @exp = create_experience
    @user = @exp.user
  end

  describe 'it can edit its experiences' do

    it 'can see edit an experience' do
      visit edit_experience_path(@exp)

      expect(current_path).to eq("/experiences/#{@exp.id}/edit")

      within('.form') do
        fill_in "Title", :with => "It's nearly 2 a.m. and Mason is to my right."
        fill_in "Duration", :with => "A few more hours until dawn"
        fill_in "Tagline", :with => "I hope you like this project. I'm delirious, but having fun, obviously."

        click_on "Update Your Experience"
        expect(current_path).to eq(experiences_path)
      end

    end
  end
end
