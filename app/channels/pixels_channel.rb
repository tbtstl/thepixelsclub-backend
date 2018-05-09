class PixelsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pixels_channel"
    @canvas = Canvas.first
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
        CanvasSerializer.new(@canvas)
    ).serializable_hash
    ActionCable.server.broadcast 'pixels_channel', serialized_data
  end

  def receive(data)
    ActionCable.server.broadcast 'pixels_channel', data
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
