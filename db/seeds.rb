# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |toilet|
  toilet = Toilet.create
  toilet.name = "Amazing porcelain throne"
  toilet.description = "AMAZING toilet for the heaviest loads"
  toilet.rate = 5
  toilet.user = 2
  toilet.address = "123 Shitty Street"
  toilet.save
end

Toilet.create(name: "Great toilet (TP included", description: "This can handle anything!", rate: 5).save
