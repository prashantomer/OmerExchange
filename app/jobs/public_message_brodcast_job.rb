class PublicMessageBrodcastJob < ApplicationJob
  queue_as :default

  def perform(*args)
    message = args[0]
    ActionCable.server.broadcast 'public_messages', message: render_content(message)
  end

  private
  def render_content message
  	ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
  end
end
