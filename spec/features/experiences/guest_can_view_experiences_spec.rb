require 'rails_helper'

RSpec.describe 'Guest visits /experiences' do

  it 'can view all experiences' do
    experiences = create_list(:experience, 4)
    experience = experiences.first
    experience.experience_images.create!(image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    visit experiences_path

    within('.navbar-header') do
      click_on "Experiences"
    end

    expect(current_path).to eq('/experiences')
    expect(page).to have_css('.experiences-box')

    within('.experiences-box') do
      expect(page).to have_css(".experience-card", count: 4)
    end

    within first('.experience-details') do
      expect(page).to have_content(experience.price)
      expect(page).to have_content(experience.title)
    end

    within first('.experience-card') do
      expect(page).to have_css('.experience-image')
      expect(page).to have_css('img', count: 1)
    end

  end

  scenario 'can view a single experience' do

    experience = create(:experience)
    cats = create_list(:experience_category, 4)
    experience.experience_categories << cats

    experience.experience_images.create!(image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    id = experience.id
    visit experiences_path

    find(:xpath, "//a[@href='/experiences/#{id}']").click
    expect(current_path).to eq("/experiences/#{id}")

    within('.experience-title-box') do
      expect(page).to have_content(experience.title)
      expect(page).to have_content(experience.city)
      expect(page).to have_content(experience.tagline)
    end

    within('.experience-category-box') do
      expect(page).to have_content(experience.experience_categories.first.name)
      expect(page).to have_content(experience.experience_categories.last.name)
      expect(page).to have_content("Hosted by: #{experience.user.full_name}")
      # expect(page).to have_xpath("//img[contains(@src,'baby_penguin.jpg')]")
      expect(page).to have_content(experience.duration)
      expect(page).to have_content(experience.provisions)
    end

    within('.experience-featured-image') do
      expect(page).to have_css('img', count: 1)
      expect(page).to have_content("#{experience.price} per person")
      #expect(page).to have_content("See Dates")
    end

    # within('.experience-date') do
    #   click_on 'See Dates'
    #   #expect a popup to pop up
    #   expect(page).to have_content(experience.dates.first)
    #   expect(page).to have_content(experience.dates.last)
    #   expect(page).to have_content("Book Now", count: 4)
    # end

    within('.experience-what-box') do
      expect(page).to have_content("What We'll Do")
      expect(page).to have_content(experience.what)
    end

    within('.experience-host-provides-box') do
      expect(page).to have_content("What I'll Provide")
      expect(page).to have_content(experience.provisions)
    end

    within('.experience-notes-box') do
      expect(page).to have_content('Notes')
      expect(page).to have_content(experience.notes)
    end

    within('.experience-where-box') do
      expect(page).to have_content("Where We'll Be")
      expect(page).to have_content(experience.where)
      expect(page).to have_css('.experience-map')
      #how to test for map accuracy?
    end

    within('.host-block') do
      expect(page).to have_content("About your host, #{experience.user.first_name}")
      #this should be unique for each experience so the host can brand himself/herself according to the experience
      expect(page).to have_content(experience.host_description)
    end

    # within('.host-contact') do
    #   expect(page).to have_link('Contact Host')
    # end

    # xit 'can view available dates' do
    #   within('.available-dates') do
    #     expect(page).to have_link("See All Dates")
    #   end
    # end
    #
    # xit 'can see reviews for the experience' do
    #   within('.experience-reviews') do
    #     expect(page).to have_content('Reviews')
    #     expect(page).to have_content(experience.reviews.first.content)
    #     expect(page).to have_content(experience.reviews.first.title)
    #     expect(page).to have_content(experience.reviews.first.name)
    #   end
    # end

    within('.experience-extras') do
      expect(page).to have_content("Extra Info")
      expect(page).to have_content(experience.group_size)
      expect(page).to have_content(experience.guest_requirements)
      expect(page).to have_content(experience.cancellation_policy_type)
    end
  end
end
