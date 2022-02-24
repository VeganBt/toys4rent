require 'faker'
require 'open-uri'
require 'geocoder'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# monopoly = Toy.create([{ name: 'tala' }, { description: 'blabla' }, { category: 'easy game' }])

# Create some users

Booking.destroy_all
Toy.destroy_all
User.destroy_all

dates = [Date.today, Date.tomorrow, Date.today + 2, Date.today + 3]
end_dates = dates.map { |date| date + 4 }

# Generate some REAL addresses
addresses = []
20.times do
  lat = rand(52.317012577088946..52.35099853609036)
  lng = rand(4.753977119685295..4.998079607423506)
  addresses << Geocoder.search([lat, lng]).first.address
end

puts "Creating 5 users...\n"

users = 5.times.each_with_object([]) do |index, arr|
  arr << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: addresses.sample,
    email: "user#{index + 1}@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )

  user.photo.attach(
    io: File.open("app/assets/images/empty_account.png"),
    filename: "empty_account.png",
    content_type: "image/png"
  )

  user.save

  puts "User ##{index + 1}"
  puts "Email: user#{index + 1}@gmail.com"
  puts "Password: 123456"
  puts ""
end

# Create some toys and associate them with users
print "Creating toys..."
toys = []

16.times do |index|
  toy = Toy.new(
    name: "#{Faker::Games::Pokemon.name} toy",
    description: Faker::Lorem.paragraph,
    category: Toy::CATEGORIES.sample,
  )
  toy.user = users.sample
  file = URI.open('https://source.unsplash.com/300x300/?toy')
  toy.photo.attach(
    io: file,
    filename: "#{index}.jpg",
    content_type: "image/jpg"
  )
  toy.save!
  toys << toy
  print "."
end

# Create some bookings
puts ""
puts "Creating bookings..."
15.times do
  booking = Booking.new(
    start_date: dates.sample,
    end_date: end_dates.sample
  )
  booking.toy = toys.sample
  booking.user = (users - [booking.toy.user]).sample
  booking.save!
end

puts "Done! 🎊"
