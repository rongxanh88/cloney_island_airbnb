require 'rails_helper'

RSpec.describe "Two Factor Authentication" do
  context "allows users to verify their phone" do
    let(:fake_verification_code) { "123456" }

    it "when they enter their code" do
      allow(CodeGenerator)
        .to receive(:generate)
        .and_return(fake_verification_code)

      traveler = create(:user, verification_code: fake_verification_code)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)

      visit ("/confirmations/new")

      expect(page).to have_content("Verification Code")

      fill_in 'confirmations[verification_code]', with: fake_verification_code
      click_on "Check Validation Code"

      expect(current_path).to eq(user_dashboard_index_path(traveler))
      expect(page).to have_content("Welcome #{traveler.first_name}")
    end
  end

  context 'user enters invalid verification code' do
    let(:fake_verification_code) { "123456" }
    it 'redirects to verification page and displays an error message' do
      allow(CodeGenerator)
        .to receive(:generate)
        .and_return(fake_verification_code)

      traveler = create(:user, verification_code: fake_verification_code)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)

      visit ("/confirmations/new")

      fill_in 'confirmations[verification_code]', with: "999999"
      click_on "Check Validation Code"

      expect(current_path).to eq(confirmations_path)
      expect(page).to have_content("Verification code is incorrect.")
    end
  end
end
