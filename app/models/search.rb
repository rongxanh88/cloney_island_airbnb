class Search < ApplicationRecord

  def self.listings_available(listings, params)
    listings.map do |listing|
      listing unless existing_trips_overlap_request(listing, params)
    end
  end

  def self.existing_trips_overlap_request(current_user, params)
    start_date = params['search_start_date'].to_date
    end_date = params['search_end_date'].to_date
    current_user.trips.any? do |trip|
      overlaps(trip, start_date, end_date)
    end
  end

  def self.check_availability(listings, params)
    params['check_in'].empty? || params['check_out'].empty? ? listings : listings_available(listings, params)
  end

  def self.overlaps(trip, start_date, end_date)
    (trip.start_date - end_date) * (start_date - trip.end_date) >= 0
  end

  def self.check_accomodations(listings, params)
    listings.select do |listing|
      listing.accomodates >= params['num_guests'].to_i
    end
  end

  def self.find_attribute(params, attribute)
    params[attribute] if Address.all.pluck(attribute.to_sym).include?(params[attribute])
  end
end
