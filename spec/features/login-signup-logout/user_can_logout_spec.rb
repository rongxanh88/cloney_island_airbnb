require 'rails_helper'

RSpec.feature "Logged in user can log out", type: :feature do
  scenario "user sees the visitor options page" do
    user = create(:user)
    role = create(:role)
    listing = create(:listing)
    listing.listing_images.create!(property_image: File.new("#{Rails.root}/lib/assets/baby_penguin.jpg"))

    user.roles << role
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    within('.navbar-user-types.nav-item') do
      click_on "Sign In"
    end

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within('.user_forms') do
      click_on "Sign In"
    end

    click_on "Sign Out"

    expect(page).to have_link "Sign In", href: login_path
    expect(page).to_not have_content("Sign Out")
  end
end
