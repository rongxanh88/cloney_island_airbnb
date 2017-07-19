class HomepageController < ApplicationController
  def index
    @listings = Listing.order("RANDOM()")
  end
end
