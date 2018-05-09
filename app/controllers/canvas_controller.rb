class CanvasController < ApplicationController
  def index
    canvas = Canvas.all
    render json: canvas
  end

  def show
    @canvas = Canvas.find(1)
    render json: @canvas
  end

  def edit
    @canvas = Canvas.first
    if @canvas.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
          CanvasSerializer.new(@canvas)
      ).serializable_hash
      PixelsChannel.broadcast 'pixels_channel', serialized_data
      head :ok
    end
  end
end
