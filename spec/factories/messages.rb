FactoryGirl.define do
  factory :message do
    conversation nil
    user nil
    content "MyString"
  end
end
