require 'rails_helper'

RSpec.describe AirbnbService do
  it 'can search by zipcode' do
    VCR.use_cassette('services/user_can_search') do
      listings = AirbnbService.find_properties('80202')

      expect(listings.count).to eq(10)
      expect(listings.first[:listing][:city]).to eq('Denver')
      expect(listings.first[:listing][:beds]).to eq('1')
      expect(listings.first[:listing][:name]).to eq('Beautiful home in Wash/Platt Park')
      expect(listings.first[:listing][:neighborhood]).to eq('Platt Park')
    end
  end

  it 'can search by city' do
    VCR.use_cassette('feature/user_can_search_by_city') do
      listings = AirbnbService.find_properties('Denver')

      expect(listings.count).to eq(10)
      expect(listings.first[:listing][:city]).to eq('Denver')
      expect(listings.first[:listing][:beds]).to eq('1')
      expect(listings.first[:listing][:name]).to eq('Beautiful home in Wash/Platt Park')
      expect(listings.first[:listing][:neighborhood]).to eq('Platt Park')
    end
  end
end