namespace :import do
  desc "Imports all seed data"
  task :all => [:regenerate, :roles, :users, :addresses, :cancellations, :amenities, :listings, :trips]

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
    Role.create!(name: "admin")
    puts "Roles loaded and seeded"
  end

  desc "Users"
  task users: :environment do
    #change to 1000 later
    10.times do |n|
      user = User.create!(
      birthday: Faker::Date.birthday(18, 97),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: "#{Faker::PhoneNumber.area_code} - #{Faker::PhoneNumber.exchange_code} - #{Faker::PhoneNumber.unique.subscriber_number}",
      email:  Faker::Internet.unique.email,
      password: "password",
      profile_picture: "http://lorempixel.com/400/300/city"
      )
      user.roles << Role.find_by(name: "traveler")

      if n % 2 == 0
        user.roles << Role.find_by(name: "host")
      end

      if n == 1
        user.roles << Role.find_by(name: "admin")
      end

      puts "user: #{user.id} created"
    end
    puts "Users loaded and seeded"
  end

  desc "Addresses"
  task addresses: :environment do
    users = User.all
    users.each do |user|
      address = Address.create!(
        street_address: Faker::Address.street_address,
        street_address_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: ["CO", "UT", "AK", "NM", "AZ", "CA", "OR", "WA", "TX", "TN", "IN", "IA"].sample,
        zip_code: Faker::Address.zip_code,
        user_id: user.id
        )
      puts "Address #{address.id} created!"
    end
    puts "Addresses loaded and seeded"
  end

  desc "Cancellations"
  task cancellations: :environment do
    Cancellation.create!(name: "Flexible", refund: '100%', description: 'Cancellation policy is flexible with 100% refund with at least 1 week notice.')
    Cancellation.create!(name: "Moderate", refund: '50%', description: 'Cancellation policy is moderate with 50% refund with at least 1 week notice.')
    Cancellation.create!(name: "Strict", refund: '0%', description: 'Cancellation policy is strict with 0% refund once listing is reserved.')
    puts "Cancellations loaded and seeded"
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
    puts "Amenities loaded and seeded"
  end

  desc "Listings"
  task listings: :environment do
    hosts = User.joins(:user_roles, :roles).where(roles: {name: "host"}).uniq
    amenities = Amenity.all
    hosts.each do |host|
      listing = Listing.create!(
        description: ["Suite of three beautifully furnished rooms set amongst the trees. Just minutes from downtown, this secluded property is an urban retreat like no other. The treehouse provides and intimate, simple and calming retreat for 2 people. The treehouse is the subject of innumerable articles, blogs and was recently featured on Treehouse Masters Ultimate Treehouses.", "Spend a unforgettable holiday in the enchanting surroundings of the town of Cisternino (reachable from the near airports of Bari and Brindisi).Trullo Edera offers a heaven of peace and tranquillity, set in an elevated position with a stunning view. It’s the perfect place if you like nature. You can stay under an olive tree reading a good book, you can have a walk in the small country streets or go to the nearest beaches.", "You can even easily visit any of the sights in Apulia such as the caves of Castellana, the trulli of Alberobello, the baroque cities of Lecce and Martina Franca, the excavations of Egnazia, the zoosafari of Fasano, Castel del Monte with Frederick’s castle, Grottaglie famous for its ceramics, Taranto, Brindisi and Lecce museums.", "Set on the sacred Ayung river valley, this all bamboo house is unique. First established in 2010, it is part of a master-planned community of luxurious bamboo villas with distinctive blonde roofs. Entering the house is a feast to the eyes and a showcase at how black and white bamboo can be combined in all shapes and pattern to create a stunning collection of luxurious floors, walls, ceiling, stairs and railings. Even the roof is an innovative arrangement of bamboo shingles."].sample,
        address_id: host.addresses.first.id,
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
        cancellation_id: [1, 2, 3].sample,
        status: ["unlisted", "listed"].sample
        )
      5.times do
        listing.amenities << amenities.sample
      end
      puts "Listing #{listing.id} created!"
    end
    puts "Listings loaded and seeded"
  end


  desc "Trips"
  task trips: :environment do
    users = User.all
    hosts = User.joins(:user_roles, :roles).where(roles: {name: "host"}).uniq
    users.each do |user|
      host = hosts.sample
      trip = Trip.create!(
        user_id: user.id,
        host_id: host.id,
        trip_status: ["requested", "pending", "accepted", "paid"].sample,
        start_date: Faker::Date.between(1.days.from_now, 3.days.from_now),
        end_date: Faker::Date.between(4.days.from_now, 6.days.from_now),
        num_guests: [*1..4].sample
      )
      puts "Trip #{trip.id} created!"
    end
    puts "Trips loaded and seeded"
  end

end
