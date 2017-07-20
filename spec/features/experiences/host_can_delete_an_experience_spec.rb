require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'As a host with experiences' do
  include ExperienceHelper

  before(:example) do
    @exp = create_experience
  end

  it 'it can delete an experience' do

    visit edit_experience_path(@exp)

    expect(current_path).to eq("/experiences/#{@exp.id}/edit")

    click_on "Erase Experience"
    expect(page).to have_content("Experience Erased!")
    expect(current_path).to eq(experiences_path)
  end


end
