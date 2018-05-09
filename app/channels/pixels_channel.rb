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
    if has_valid_keys data
      @canvas = Canvas.first
      @canvas = @canvas.update_pixel data["x"], data["y"], data["color"]
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
          CanvasSerializer.new(@canvas)
      ).serializable_hash
      ActionCable.server.broadcast 'pixels_channel', serialized_data
    else
      p "data does not have valid keys"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private
  def has_valid_keys(data)
    valid = data.key?("x") && data.key?("y") && data.key?("color")
    p "valid? #{valid}"
  end
end
