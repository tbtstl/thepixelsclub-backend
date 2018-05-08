class PixelsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pixels_channel"
  end

  def receive(data)
    ActionCable.server.broadcast 'pixels_channel', data
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
