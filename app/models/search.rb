class Search < ApplicationRecord

  def self.return_search(params)
    listings = find_listings(params)
    params['check_in'].empty? || params['check_out'].empty? ? listings : listings_available(listings, params)
  end

  private

    def self.find_listings(params)
      if params['zip_code'].empty?
        Listing.find_by_sql(["SELECT * FROM listings JOIN addresses ON listings.address_id = addresses.id WHERE addresses.city LIKE ? AND addresses.state = ?", find_attribute(params, 'city'), find_attribute(params, 'state')])
      else
        Listing.find_by_sql(["SELECT * FROM listings JOIN addresses ON listings.address_id = addresses.id WHERE addresses.zip_code = ?", find_attribute(params, 'zip_code')])
      end
    end

    def self.listings_available(listings, params)
      available_listings = listings.map do |listing|
        listing unless existing_trips_overlap_request(listing, params)
      end
    end

    def self.existing_trips_overlap_request(listing, params)
      start_date = params['check_in'].to_date
      end_date = params['check_out'].to_date

      listing.trips.any? do |trip|
        overlaps(trip, start_date, end_date)
      end
    end

    def self.overlaps(trip, start_date, end_date)
      (trip.start_date - end_date) * (start_date - trip.end_date) >= 0
    end

    def self.find_attribute(params, attribute)
      params[attribute] if Address.all.pluck(attribute.to_sym).include?(params[attribute])
    end
end
