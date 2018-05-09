require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Canvas.destroy_all

pixels = Array.new(32) {Array.new(32, '#FFFFFF')}

Canvas.create!({
                   singleton_guard: 0,
                   pixels: pixels.to_json
               })

p "Created #{Canvas.count} Canvas"