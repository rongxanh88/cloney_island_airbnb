class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    if Listing.exists?(params[:format])
      @listing = Listing.find(params[:format])
    else
      @listing = AirbnbService.find_listing(params[:format])
    end
    @message = Message.new
  end

  def create
    @conversation = Conversation.new(trip_id: params[:trip_id])
    if @conversation.save
      redirect_to conversation_path(@conversation)
    end
  end

  def index
    @listin
    @conversations = current_user.conversations.uniq
  end
end
