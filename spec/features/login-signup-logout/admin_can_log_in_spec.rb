require 'rails_helper'

RSpec.feature "Admin can log in", type: :feature do
  scenario "admin logs in successfully" do
    skip
    admin = create(:user)
    admin_role = create(:role, name: "admin")
    admin.roles << admin_role

    visit login_path

    within ".navbar-user-types" do
      click_on "Sign In"
    end

    expect(current_path).to eq(new_user_path)

    fill_in :user_email, with: "#{admin.email}"
    fill_in :user_password, with: "#{admin.password}"

    expect(current_path).to eq('/login')
    expect(flash[:success]).to match(/You have successfully been logged in!/)
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Sign Out")
  end
end
