require 'rails_helper'

RSpec.feature "Admin can log in", type: :feature do
  xscenario "admin logs in successfully" do

    #THIS TEST REQUIRES SOME SETTING UP, THE ONLY USEFUL ADMIN RIGHTS WOULD BE THE ABILITY TO DELETE USERS, AN ADMIN DASHBOARD WOULDN'T NEED TO EXIST, BUT IF A USER IS AN ADMIN, THE DASHBOARD COULD INCLUDE A DELETE USERS BUTTON

    admin = create(:user)
    admin_role = create(:role, name: "admin")
    admin.roles << admin_role

    visit login_path

    within ".navbar-user-types" do
      click_on "Sign In"
    end

    expect(current_path).to eq('/login')
    #save_and_open_page

    fill_in :Email, with: "#{admin.email}"
    fill_in :Password, with: "#{admin.password}"

    expect(current_path).to eq('/login')
    #expect(flash[:success]).to match(/You have successfully been logged in!/)
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Sign Out")
  end
end
