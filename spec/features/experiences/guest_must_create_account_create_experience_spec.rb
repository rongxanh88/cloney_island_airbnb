require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'As a guest' do
  include ExperienceHelper

  it 'must create an account to create an experience' do
    visit new_experience_path

    expect(current_path).to eq(login_path)
  end

end
