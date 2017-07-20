class CreateListingsJob < ApplicationJob
  queue_as :urgent

  def perform
    listing_attrs = $redis.get("listing")
    $redis.del("listing")

    #L unless listing_attrs.nil?
  end
end
