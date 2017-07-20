FactoryGirl.define do
  factory :experience_image do
    image_file_name { '/lib/assets/baby_penguin.jpg' }
    image_content_type { 'image/jpg' }
    image_file_size { 1024 }
    experience
  end
end
