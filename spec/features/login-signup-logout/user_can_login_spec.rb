require 'rails_helper'

RSpec.feature "As a user with an account", type: :feature do
    scenario "user can log in" do
      user = create(:user)
      visit login_path

      within('.navbar-user-types.nav-item') do
        click_on 'Sign In'
      end

      expect(current_path).to eq(login_path)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button 'Sign In'

      expect(current_path).to eq(user_dashboard_index_path(user))

      expect(page).to have_content("Logged in as #{user.first_name}")
      expect(page).not_to have_content("Sign Up")
      expect(page).to have_content("Sign Out")
      expect(page).to have_content("Messages")
      expect(page).to have_content("Trips")
    end

    it "must enter a password to login" do
      user = create(:user)

      visit login_path

      within('.navbar-user-types.nav-item') do
        click_on 'Sign In'
      end

      click_button 'Sign In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("The email or password you entered is invalid")

    end

  end
