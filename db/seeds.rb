# Clear old data
User.destroy_all

# Create sample users
User.create!(username: "Brian")
User.create!(username: "Osieku")
User.create!(username: "Tum")

puts "Seeded #{User.count} users"

