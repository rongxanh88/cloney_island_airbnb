require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'Authenticated user visits experiences_path' do
  include ExperienceHelper

  before(:example) do
    @exps = create_many_experiences
    @user = @exps.first.user
  end

  it 'can view all experiences' do

    visit experiences_path

    within('.navbar-user-types.sub') do
      click_on 'Experiences'
    end

    expect(current_path).to eq('/experiences')

    within('.experiences-box') do
      expect(page).to have_content(@exps[0].title)
      expect(page).to have_content(@exps[1].title)
      expect(page).to have_content(@exps[2].title)
      expect(page).to have_content(@exps[3].title)

      expect(page).to have_css('.experience-image', count: 8)

      expect(page).to have_content(@exps[0].price)
      expect(page).to have_content(@exps[1].price)
      expect(page).to have_content(@exps[2].price)
      expect(page).to have_content(@exps[3].price)
    end
  end
end
