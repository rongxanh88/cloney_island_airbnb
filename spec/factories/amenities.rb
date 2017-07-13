FactoryGirl.define do
  factory :amenity do
    sequence(:name) do  |i|
      "shit in the cabinet #{i}"
    end
  end
end
