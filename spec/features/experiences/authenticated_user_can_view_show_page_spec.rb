require 'rails_helper'
require_relative 'experience_helper'

RSpec.describe 'Authenticated user visits experience_path' do
  include ExperienceHelper

  before(:example) do
    @exps = create_many_experiences
    @user = @exps.first.user
    @exp = @exps[0]
    visit experience_path(@exp)
  end

  describe 'and can see a full experience' do

    it 'can see title block' do
      expect(current_path).to eq("/experiences/#{@exp.id}")

      within('.experience-title-box') do
        expect(page).to have_content(@exp.title)
        expect(page).to have_content(@exp.city)
        expect(page).to have_content(@exp.tagline)
      end

    end

    it 'can see category block' do
      within('.experience-category-box') do
        expect(page).to have_content("Hosted by: #{@exp.user.full_name}")
        expect(page).to have_css('.host-profile-pic img')
        expect(page).to have_content(@exp.duration)
        expect(page).to have_content(@exp.provisions)
      end
    end

    it 'can see what we will do block' do
      within('.experience-what-box') do
        expect(page).to have_content("What We'll Do")
        expect(page).to have_content(@exp.what)
      end
    end

    it 'can see what host will provide block' do
      within('.experience-host-provides-box') do
        expect(page).to have_content("What I'll Provide")
        expect(page).to have_content(@exp.provisions)
      end
    end

    it 'can see notes block' do
      within('.experience-notes-box') do
        expect(page).to have_content('Notes')
        expect(page).to have_content(@exp.notes)
      end
    end

    it 'can see where it will be block' do
      within('.experience-where-box') do
        expect(page).to have_content("Where We'll Be")
        expect(page).to have_content(@exp.where)
      end
    end

    it 'can see host details block' do
      within('.host-block') do
        expect(page).to have_content("About your host, #{@exp.user.first_name}")
        expect(page).to have_content(@exp.host_description)
      end
    end

    it 'can see host contact block' do
      within('.host-contact') do
        #expect(page).to have_content('Contact Host') #links to messaging system
      end
    end

    it 'can see the extras block' do
      within('.experience-extras') do
        expect(page).to have_content("Group Size: #{@exp.group_size}")
        expect(page).to have_content("Guest Requirements: #{@exp.guest_requirements}")
        expect(page).to have_content("Cancellation Policy Type: #{@exp.cancellation_policy_type}")
      end
    end

  end
end
