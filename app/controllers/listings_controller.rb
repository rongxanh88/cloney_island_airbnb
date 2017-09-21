class ListingsController < ApplicationController
  def index
    location = params['search_address']
    @results = Airbnb.find_properties(location)
    @geojson = Array.new
    build_geojson(@results, @geojson)

    respond_to do |format|
      format.html
      format.json {render json: @geojson}
    end
  end

  def show
    if Listing.exists?(params[:id])
      @listing = Listing.find(params[:id])
    else
      @listing = Airbnb.find(params[:id])
    end
  end


  def build_geojson(results, geojson)
    results.each do |result|
      geojson << GeojsonBuilder.build_listing(result)
    end
  end
end
