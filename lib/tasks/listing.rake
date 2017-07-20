namespace :listing do
  desc "Check Redis"
  task :all => [:create_listing, :delete_listing]

  desc "checks redis for listings waiting to be created"
  task :create_listing do
    listing_attrs = $redis.get("listing")
    $redis.del("listing")
    Listing.create!(listing_attrs) unless listing_attrs.nil?
  end

  desc "checks redis for listings waiting to be deleted"
  task :delete_listing do
    listing_id = $redis.get("del_listing")
    $redis.del("del_listing")
    Listing.destroy(listing_id) unless listing_id.nil?
  end
end