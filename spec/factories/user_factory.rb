FactoryGirl.define do
  factory :user, aliases: [:host] do
    first_name "Paul"
    last_name "Simon"
    sequence(:phone_number) do |n|
      "#{n}04-32#{n}-212#{n}"
    end
    sequence(:email) do |n|
      "paul#{n}@email.com"
    end
    password "password"
    birthday "2017-07-11"
    profile_picture { File.new("#{Rails.root}/lib/assets/baby_penguin.jpg") }
  end
end
