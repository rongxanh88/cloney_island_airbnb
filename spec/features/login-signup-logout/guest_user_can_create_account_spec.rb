require 'rails_helper'

RSpec.describe 'As a guest user' do

  it 'can create an account' do
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
    fill_in "Phone number", with: "720-290-0960"
    select "2012", from: "user_birthday_1i"
    select "March", from: "user_birthday_2i"
    select "14", from: "user_birthday_3i"
    fill_in "Password", with: "password"

    within(".create-account-box") do
      click_on "Sign Up"
    end

    expect(current_path).to eq('/confirmations/new')
  end

end
