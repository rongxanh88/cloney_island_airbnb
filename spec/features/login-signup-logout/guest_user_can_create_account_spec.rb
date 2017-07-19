require 'rails_helper'

RSpec.describe 'As a guest user' do

  xit 'can create an account' do
    user = build(:user)
    create(:role)

    visit '/'

    within('.navbar-user-types') do
      click_on "Sign Up"
    end

    expect(current_path).to eq(new_user_path)

    fill_in "Email", with: "t@tty.com"
    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Phone number", with: "444-332-5032"
    select "2012", from: "user_birthday_1i"
    select "March", from: "user_birthday_2i"
    select "14", from: "user_birthday_3i"
    fill_in "Password", with: "password"

    within(".create-account-box") do
      click_on "Sign Up"
    end

    user = User.find_by(phone_number: "444-332-5032")

    expect(current_path).to eq(user_dashboard_index_path(user))
    expect(page).not_to have_content("Sign Up")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Messages")
    expect(page).to have_content("Trips")
  end

end
