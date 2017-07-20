class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  def create
    @conversation = Conversation.new(trip_id: params[:trip_id])
    if @conversation.save
      redirect_to conversation_path(@conversation)
    end
  end

  def index
    @conversations = current_user.conversations.uniq
  end
end