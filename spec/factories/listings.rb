FactoryGirl.define do
  factory :listing do
    user

    sequence(:name) do  |i|
      "Best Place on Earth #{i}"
    end
    description 'Place new description here'
    address '123 Billygoat Rd. Evergreen, CO 80411'
    accomodates 3
    bathrooms 3
    bedrooms 2
    beds 6
    price 25.99
    house_rules 'No smoking'
    property_type 'apartment'
    bed_type 'king'
    pet_type 'cat_and_dog'
    room_type 'entire_home'
    cancellation_policy 0
    status 0
    latitude "59.325"
    longitude "18.070 "
  end


end
