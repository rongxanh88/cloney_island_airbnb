class CreateListingsJob < ApplicationJob
  queue_as :urgent

  def perform
    listing_attrs = $redis.get("listing")
    $redis.del("listing")
    Listing.create!(listing_attrs) unless listing_attrs.nil?
  end
end
