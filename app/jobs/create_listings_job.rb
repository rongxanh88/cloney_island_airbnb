class CreateListingsJob < ApplicationJob
  queue_as :urgent

  def perform
    listing_attrs = $redis.get("listing")
    $redis.del("listing")
    if listing_attrs != nil
      formatted_attrs = JSON.parse(listing_attrs)
      Listing.create!(formatted_attrs)
    end
  end
end
