# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Camera.destroy_all

50.times do
  camera = Camera.new({
    category: ["Camera", "Accessory", "Lense", "Tripod"].sample,
    brand: ["Canon", "Nikkon", "Arri", "Aaton", "Red", "Black magic"].sample,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price
    })
  camera.save
end
