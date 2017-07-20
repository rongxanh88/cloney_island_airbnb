class MessagesController < ApplicationController

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'room_channel',
                                   content:  message.content,
                                   first_name: message.user.first_name
      head :ok
    else
      render 'index'
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :conversation_id)
    end
end
