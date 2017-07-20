FactoryGirl.define do
  factory :experience_category do
    sequence(:name) { |n| "Caspian Star #{n}" }
  end
end
