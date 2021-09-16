# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Chewy.strategy(:atomic) do
  print "\nStarts cities seeding\t"
  10.times do
    FactoryBot.create(:city)
    print '.'
  end
  puts "\nCities are created!"

  print "\nStarts users seeding\t"
  20.times do
    FactoryBot.create(:user, city_id: rand(1..10))
    print '.'
  end
  puts "\nUsers are created!"
end
