FactoryGirl.define do
  factory :experience do
    title {Faker::Zelda.character}
    duration  {"#{Faker::Number.between(1, 10)} hours"}
    tagline {Faker::Zelda.game}
    what {Faker::ElderScrolls.creature}
    where {Faker::ElderScrolls.region}
    provisions {Faker::Food.dish}
    notes {Faker::Simpsons.quote}
    price {Faker::Number.between(10, 300)}
    host_description {Faker::Lovecraft.paragraph(2)}
    group_size Faker::Number.between(1, 10)
    guest_requirements {Faker::MostInterestingManInTheWorld.quote}
    cancellation_policy_type {Faker::Lovecraft.word}
    street_address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state_abbr}
    zipcode {Faker::Number.between(10101, 90909)}
    user
  end
end
