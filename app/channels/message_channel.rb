class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "public_messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak message
    message.symbolize_keys!
    # ActionCable.server.broadcast 'public_messages', message: message[:message]
    Message.create! message.slice(:message)
  end
end
