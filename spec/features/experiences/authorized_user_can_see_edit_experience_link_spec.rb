require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'Authorized users can see edit link' do
  include ExperienceHelper

  before(:example) do
    @exp = create_experience
    @user = @exp.user
  end

  describe 'it visits own experience page' do

    it 'can see edit link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit experiences_path

      within first('.experience-image') do
        first(:xpath, "//a[@href='/experiences/#{@exp.id}']").click
      end

      expect(current_path).to eq("/experiences/#{@exp.id}")
      expect(page).to have_css('.host-edit-link')
      within('.host-edit-link') do
        expect(page).to have_content('Edit Your Experience')
      end
    end

  end

  describe 'it cannot see link on another host experience page' do

    it 'cannot see edit link' do
      disallowed_user = create(:user)
      disallowed_user.roles << @role_host

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(disallowed_user)

      visit experiences_path

      within first('.experience-image') do
        first(:xpath, "//a[@href='/experiences/#{@exp.id}']").click
      end

      expect(current_path).to eq("/experiences/#{@exp.id}")
      expect(page).to_not have_css('.host-edit-link')
      expect(page).to_not have_content('Edit Your Experience')

    end

  end

  describe 'a guest cannot see the edit link' do

    it 'cannot see edit link' do
      disallowed_guest = create(:user)

      visit experiences_path

      within first('.experience-image') do
        first(:xpath, "//a[@href='/experiences/#{@exp.id}']").click
      end

      expect(current_path).to eq("/experiences/#{@exp.id}")
      expect(page).to_not have_css('.host-edit-link')
      expect(page).to_not have_content('Edit Your Experience')

    end

  end

end
