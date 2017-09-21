require 'faraday-manual-cache'

class AirbnbService

  def initialize(location = 0)
    @location = location
    @conn = Faraday.new(url: "https://www.airbnb.com/") do |faraday|
        faraday.headers["X-API-KEY"] = ENV["airbnb_key"]
        faraday.use :manual_cache,
                    expires_in: 50
        faraday.adapter Faraday.default_adapter
    end
  end

  def find_properties
    get_url("/api/v2/search_results?client_id=#{ENV['airbnb_key']}&locale=en-US&currency=USD&_format=for_search_results_with_minimal_pricing&_limit=10&_offset=0&fetch_facets=true&guests=1&ib=false&ib_add_photo_flow=true&location=#{location}US&min_beds=1&min_num_pic_urls=10&sort=1")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:search_results]
  end

  def self.find_properties(location)
    new(location).find_properties
  end

  def self.find_listing(id)
    new.find_listing(id)
  end

  def find_listing(id)
    response = @conn.get("/api/v2/listings/#{id}?client_id=#{ENV['airbnb_key']}&_format=v1_legacy_for_p3&locale=en-US&_source=mobile_p3&number_of_guests=1")
    result = JSON.parse(response.body, symbolize_names: true)
    listing = Airbnb.new(result)
  end

  def self.generate_host_by_listing_id(id)
    new.generate_host_by_listing_id(id)
  end

  def generate_host_by_listing_id(id)
    response = @conn.get("/api/v2/listings/#{id}?client_id=#{ENV['airbnb_key']}&_format=v1_legacy_for_p3&locale=en-US&_source=mobile_p3&number_of_guests=1")
    result = JSON.parse(response.body, symbolize_names: true)
    host = AirbnbHost.create_host(result[:listing][:user][:user], id)
  end

  def self.find_listings(id_array)
    new.find_listings(id_array)
  end

  def find_listings(id_array)
    listings = []
    id_array.each do |id|
      if Listing.find(id).airbnb_id == 1
        listings << Listing.find(id)
      else
        listings << find_listing(Listing.find(id).airbnb_id)
      end
    end
    listings
  end

  private

  attr_reader :location
end

