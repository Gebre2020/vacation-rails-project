# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(username: "sam", email: "sam@sam.com", password: "sam")

travel1 = Travel.create(name: "Willis Tower", address: "233 S. Wacker Dr.")

location1 = Location.create(user_id: user1.id, city: "Chicago", country: "IL, USA")

Trip.create(location_id: location1.id, travel_id: travel1.id)

