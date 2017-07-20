class DeleteListingsJob < ApplicationJob
  queue_as :urgent

  def perform
    listing_id = $redis.get("del_listing")
    $redis.del("del_listing")
    Listing.destroy(listing_id) unless listing_id.nil?
  end
end
