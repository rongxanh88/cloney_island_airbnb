class SearchController < ApplicationController
  def index
    @available_listings = Search.return_search(params)
  end
end
