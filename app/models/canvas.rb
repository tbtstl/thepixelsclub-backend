class Canvas < ApplicationRecord
  validates :singleton_guard, inclusion: {in: [0]}

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

  def self.method_missing(method, *args)
    if Canvas.instance.methods.include?(method)
      Canvas.instance.send(method, *args)
    else
      super
    end
  end
end
