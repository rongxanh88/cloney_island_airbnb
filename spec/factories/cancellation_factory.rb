FactoryGirl.define do
  factory :cancellation do
    name 'Flexible'
    refund 'Full refund 1 day prior to arrival'
    description "The Airbnb service fee is refundable (up to 3 times per year) if the guest cancels before the trip starts. If a guest books a reservation that overlaps with any part of an existing reservation, we won’t refund the Airbnb service fee if they decide to cancel."
  end
end
