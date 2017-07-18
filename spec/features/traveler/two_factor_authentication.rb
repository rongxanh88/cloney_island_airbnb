require 'rails_helper'

RSpec.describe "Two Factor Authentication" do
  context "allows users to reset a forgotten password" do
    let(:fake_verification_code) { "123456" }

    it "when they are logged in" do
      allow(CodeGenerator)
      .to receive(:generate)
      .and_return(fake_verification_code)

      traveler = create(:user)

      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(traveler)

      visit edit_user_path

      VCR.use_cassette("twilio-accounts-messages") do
        click_on "Change Password"
      end

      expect(current_path).to eq('#')
      expect(page).to have_content("Verification Code")

      expect(page).to have_button("Confirm")

      fill_in "verification_code", with: fake_verification_code
      click_on "Confirm"

      expect(page).to have_content("Verification code is correct!")
    end

    it "when they are logged out" do

    end
  end
end
