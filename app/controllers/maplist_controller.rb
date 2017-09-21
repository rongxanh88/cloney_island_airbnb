# class MaplistController < ApplicationController
#   def index
#     @listings = Listing.all
#     @geojson = Array.new
#     build_geojson(listing, @geojson)
#   end
#
#   respond_to do |format|
#     format.html
#     format.json {render json: @geojson}
#   end
#
#   def build_geojson(listings, geojson)
#     listings.each do |listing|
#       geojson << GeojsonBuilder.build_listing(listing)
#     end
#   end
# end
