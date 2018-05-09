class Canvas < ApplicationRecord
  validates :singleton_guard, inclusion: {in: [0]}
  validate :in_json_format
  validate :has_correct_dimensions

  def self.instance
    # There will only be one row, so its ID must be '1'
    begin
      find(1)
    rescue ActiveRecord::RecordNotFound
      canvas = Canvas.new
      canvas.singleton_guard = 0
      row.save!
      row
    end
  end

  def update_pixel(x, y, color)
    begin
      pixels = JSON.parse(self.pixels)
      pixels[x.to_i][y.to_i] = color
      self.update(pixels: pixels)
      self.save
      self
    rescue IndexError
    end
  end

  def self.method_missing(method, *args)
    if Canvas.instance.methods.include?(method)
      Canvas.instance.send(method, *args)
    else
      super
    end
  end

  private
  def in_json_format
    errors[:base] << "Not valid JSON" unless !!JSON.parse(self.pixels)
  end

  private
  def has_correct_dimensions
    begin
      pixels = JSON.parse self.pixels
      if pixels.length != 32
        errors[:base] << "Pixels dimension size is not 32x32"
      end
      pixels.each do |row|
        if row.length != 32
          errors[:base] << "Pixels dimension size is not 32x32"
          break
        end
      end
    end
  end
end
