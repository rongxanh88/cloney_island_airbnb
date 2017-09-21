class Airbnb

  attr_reader :name,
              :beds,
              :room_type,
              :price,
              :listing_image,
              :id,
              :address,
              :bedrooms,
              :bathrooms,
              :description,
              :accomodates,
              :bed_type,
              :pet_type,
              :property_type,
              :house_rules,
              :cancellation_policy,
              :listing_images,
              :user_id,
              :amenities,
              :longitude,
              :latitude,
              :listing_id,
              :user_first_name,
              :user_profile_picture

  def initialize(search)
    @id             = search[:listing][:id]
    @name           = search[:listing][:name]
    @description    = search[:listing][:description]
    @bedrooms       = search[:listing][:beds]
    @bathrooms      = search[:listing][:bathrooms]
    @beds           = search[:listing][:beds]
    @address        = search[:listing][:address]
    @room_type      = search[:room_type_category]
    @price          = nil
    @listing_image = search[:listing][:picture_url]
    @bed_type       = search[:listing][:bed_type]
    @accomodates    = search[:listing][:person_capacity]
    @property_type  = search[:listing][:property_type]
    @pet_type       = nil
    @house_rules    = nil
    @cancellation_policy = search[:listing][:cancellation_policy]
    @user_id        = search[:listing][:user_id]
    @listing_images = search[:listing][:picture_urls]
    @amenities      = []
    @listing_id     = nil
    @latitude       = search[:listing][:lat]
    @longitude      = search[:listing][:lng]
    @user_first_name = nil
    @user_profile_picture = search[:listing][:user][:picture_url]
    amenity_find_or_create(search)
    user_name_and_pic(search)
    listing_id_create(@id)
    find_price(search)
  end

  def self.find_properties(location)
    properties = AirbnbService.find_properties(location)
    properties.map do |property|
      new(property)
    end
  end

  def self.find(id)
    AirbnbService.find_listing(id)
  end

  def listing_id_create(id)
    @listing_id = Listing.find_or_create_by!(airbnb_id: id).id
  end

  def user_name_and_pic(search)
    if search[:listing][:user][:user]
      @user_profile_picture = search[:listing][:user][:user][:picture_url]
      @user_first_name = search[:listing][:user][:user][:first_name]
    else
      @user_profile_picture = search[:listing][:user][:picture_url]
      @user_first_name = search[:listing][:user][:first_name]
    end
  end

  def find_price(search)
    if search[:pricing_quote]
      @price = search[:pricing_quote][:rate][:amount]
    elsif search[:listing][:price]
      @price = search[:listing][:price]
    else
      nil
    end
  end

  def amenity_find_or_create(search)
    if search[:listing][:amenities]
      search[:listing][:amenities].each do |amenity|
        if Amenity.find_by(name: amenity)
          amenity = Amenity.find_by(name: amenity)
          @amenities << amenity
        else
          amenity = Amenity.create(name: amenity)
          @amenities << amenity
        end
      end
    end
  end
end
