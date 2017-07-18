class Host::ListingsController < ApplicationController
  def index
    @listings = current_user.listings
  end

  def show
    @listing = current_user.listings.find(params[:id])
  end

  def new
    @listing = current_user.listings.new
  end

  def create
    listing = current_user.listings.new(listing_params)
    amenities = Amenity.list_amenities(amenities_params)
    if listing.save
      listing.amenities << amenities
      redirect_to listing_path(listing)
    else
      flash[:message] = "Unable to create new listing"
      redirect_to new_user_hosts_listing_path(current_user)
    end
  end

  def edit
    @listing = current_user.listings.find(params[:id])
  end

  def update
    listing = Listing.find(params[:id])
    listing.update_attributes(listing_params)
    listing.amenities.clear
    amenities = Amenity.list_amenities(amenities_params)
    if listing.save
      listing.amenities << amenities
      redirect_to user_host_listing_path(current_user, listing)
    else
      flash[:message] = "Unable to update listing"
      redirect_to edit_user_host_listing_path(current_user, listing)
    end
  end

  private

    def listing_params
      params.require(:host)
            .permit(
              :name, :description, :address, :house_rules, :accomodates,
              :bathrooms, :bedrooms, :beds, :price, :property_type,
              :bed_type, :room_type, :pet_type, :cancellation_policy
            )
    end

    def amenities_params
      params.require(:host).require(:listing_amenities)
    end

end
