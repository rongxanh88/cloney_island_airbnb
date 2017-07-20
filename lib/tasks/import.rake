require 'csv'

namespace :import do
    desc "Imports all seed data"
    task :all => [:regenerate, :roles, :users, :amenities, :listings, :listing_images, :trips, :experience_categories, :experiences, :experience_images]

    desc "wipes database before seeding"
    task :regenerate do
      Rails.env = "development"
      Rake::Task["db:reset"].invoke
      Rails.env = "test"
      Rake::Task["db:reset"].invoke
    end

    desc "Roles"
    task roles: :environment do
      Role.create!(name: "traveler")
      Role.create!(name: "host")
      puts "Roles loaded"
    end

    desc "Users"
    task users: :environment do
      #change to 1000 later
      30.times do |n|
        user = User.create!(
        birthday: Faker::Date.birthday(18, 97),
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone_number: "#{[*100..999].sample}-555-#{Faker::PhoneNumber.unique.subscriber_number}",
        email:  Faker::Internet.unique.email,
        password: "password",
        profile_picture: "http://lorempixel.com/400/300/cats",
        api_token: SecureRandom.uuid.gsub(/\-/,'')
        )
        user.roles << Role.find_by(name: "traveler")

        if n % 2 == 0
          user.roles << Role.find_by(name: "host")
        end

        puts "user: #{user.id} created"
      end
      puts "Users loaded"
    end

    desc "Amenities"
    task amenities: :environment do
      Amenity.create!(name: "Kitchen")
      Amenity.create!(name: "Essentials/Toiletries")
      Amenity.create!(name: "Air Conditioning")
      Amenity.create!(name: "Heating")
      Amenity.create!(name: "Washer/Dryer")
      Amenity.create!(name: "TV")
      Amenity.create!(name: "Private Entrance")
      Amenity.create!(name: "Living Room")
      Amenity.create!(name: "Wifi")
      Amenity.create!(name: "Hot Tub")
      Amenity.create!(name: "Fire Extinguisher")
      puts "Amenities loaded"
    end

    desc "Listings"
    task listings: :environment do
      hosts = User.joins(:user_roles, :roles).where(roles: {name: "host"}).uniq
      amenities = Amenity.all
      addresses = import_addresses(hosts.count)
      n = 0
        hosts.each do |host|

          listing = Listing.create!(
          description: ["Suite of three beautifully furnished rooms set amongst the trees. Just minutes from downtown, this secluded property is an urban retreat like no other. The treehouse provides and intimate, simple and calming retreat for 2 people. The treehouse is the subject of innumerable articles, blogs and was recently featured on Treehouse Masters Ultimate Treehouses.", "Spend a unforgettable holiday in the enchanting surroundings of the town of Cisternino (reachable from the near airports of Bari and Brindisi).Trullo Edera offers a heaven of peace and tranquillity, set in an elevated position with a stunning view. It’s the perfect place if you like nature. You can stay under an olive tree reading a good book, you can have a walk in the small country streets or go to the nearest beaches.", "You can even easily visit any of the sights in Apulia such as the caves of Castellana, the trulli of Alberobello, the baroque cities of Lecce and Martina Franca, the excavations of Egnazia, the zoosafari of Fasano, Castel del Monte with Frederick’s castle, Grottaglie famous for its ceramics, Taranto, Brindisi and Lecce museums.", "Set on the sacred Ayung river valley, this all bamboo house is unique. First established in 2010, it is part of a master-planned community of luxurious bamboo villas with distinctive blonde roofs. Entering the house is a feast to the eyes and a showcase at how black and white bamboo can be combined in all shapes and pattern to create a stunning collection of luxurious floors, walls, ceiling, stairs and railings. Even the roof is an innovative arrangement of bamboo shingles."].sample,
          address: "#{addresses[n]} Denver CO, 80205",
          user_id: host.id,
          property_type: [0, 1, 2, 3, 4].sample,
          room_type: [0, 1, 2].sample,
          bed_type: [0, 1, 2, 3, 4, 5].sample,
          accomodates: [1, 2, 3, 4, 5, 6].sample,
          bathrooms: [1, 2, 3, 4, 5, 6].sample,
          name: "Home of #{Faker::Ancient.god} #{host.id}",
          bedrooms: [1, 2, 3, 4, 5, 6].sample,
          beds: [1, 2, 3, 4, 5, 6].sample,
          pet_type: [0, 1, 2, 3, 4].sample,
          price: [100, 200, 300, 400, 500, 600].sample,
          house_rules: ["No Smoking", "No Teenagers", "Hippies Use Back Door"].sample,
          cancellation_policy: [0, 1, 2].sample,
          status: ["unlisted", "listed"].sample
          )
          5.times do
            listing.amenities << amenities.sample
          end
          n += 1
          puts "Listing #{listing.id} created!"
      end
      puts "Listings loaded"
    end

    desc "Listing Images"
    task listing_images: :environment do
      listings = Listing.all
      listings.each do |listing|
        3.times do
          listing.listing_images.create!(property_image: "http://lorempixel.com/400/300/city")
        end
        puts "listing #{listing.id} images loaded"
      end
      puts "Listing Images loaded"
    end

    desc "Trips"
    task trips: :environment do
      listings = Listing.all
      users = User.all
      #hosts = User.joins(:user_roles, :roles).where(roles: {name: "host"}).uniq
      users.each do |user|
        listing = listings.sample
        #host = hosts.sample
        trip = Trip.create!(
        listing_id: listing.id,
        user_id: user.id,
        host_id: listing.user_id,
        trip_status: ["requested", "pending", "accepted", "paid"].sample,
        start_date: Faker::Date.between(1.days.from_now, 3.days.from_now),
        end_date: Faker::Date.between(4.days.from_now, 6.days.from_now),
        num_guests: [*1..listing.accomodates].sample
        )
        puts "Trip #{trip.id} created!"
        conversation = Conversation.create(trip_id: trip.id)
        puts "Conversation for #{trip.id} initiated!"
      end
      puts "Trips loaded"
    end

    desc "Experience Categories"
    task experience_categories: :environment do

      ExperienceCategory.create!(name: "Arts")
      ExperienceCategory.create!(name: "Entertainment")
      ExperienceCategory.create!(name: "Business")
      ExperienceCategory.create!(name: "Sports")
      ExperienceCategory.create!(name: "Outdoors")

      puts "Experience Categories created!"
      puts "Experience Categories loaded"
    end

    desc "Experience"
    task experiences: :environment do
      hosts = User.joins(:user_roles, :roles).where(roles: {name: "host"}).uniq
      categories = ExperienceCategory.all
      n = 0
        hosts.each do |host|

          experience = Experience.create!(
            title: Faker::Zelda.character,
            duration:  "#{Faker::Number.between(1, 10)} hours",
            tagline: Faker::Zelda.game,
            what: Faker::ElderScrolls.creature,
            where: Faker::ElderScrolls.region,
            provisions: Faker::Food.dish,
            notes: Faker::Simpsons.quote,
            price: Faker::Number.between(10, 300),
            host_description: Faker::Lovecraft.paragraph(2),
            group_size: Faker::Number.between(1, 10),
            guest_requirements: Faker::MostInterestingManInTheWorld.quote,
            cancellation_policy_type: Faker::Lovecraft.word,
            street_address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zipcode: Faker::Number.between(10101, 90909),
            user_id: host.id
          )
          2.times do
            experience.experience_categories << categories.sample
          end
          n += 1
          puts "Experience #{experience.id} created!"
        end
      puts "Experiences loaded"
    end

    desc "Experience Images"
    task experience_images: :environment do
      experiences = Experience.all
      experiences.each do |experience|
        3.times do
          experience.experience_images.create!(image: "http://lorempixel.com/400/300/city")
        end
        puts "experience #{experience.id} images loaded"
      end
      puts "Experience Images loaded"
    end


  private

  def import_addresses(n)
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'addresses.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO -8859-1')
    i = 0
    addresses = []
    csv.each do |row|
      # listing = Listing.new
      addresses << row['FULL_ADDRESS']
      # listing.save
      if n == i
        break
      end
      i += 1
    end
    addresses
  end
end
