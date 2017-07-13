FactoryGirl.define do
  factory :address do
    street_address '123 Fake St.'
    street_address_2 'Unit 22'
    city 'Denver'
    state 'Colorado'
    zip_code '80202'

    user
  end
end
