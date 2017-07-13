FactoryGirl.define do
  factory :trip do
    user
    host

    trip_status 1
    start_date "2017-07-12"
    end_date "2017-07-12"
    num_guests 1
  end
end
