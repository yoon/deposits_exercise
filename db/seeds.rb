# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do
  tl = Tradeline.create(name: Faker::Company.name, amount: Faker::Number.between(from: 0.0, to: 1000.0).round(2))
  (2..8).to_a.sample.times do
    tl.deposits.create(deposit_on: Faker::Date.forward(days: 10), amount: Faker::Number.between(from: 0.0, to: tl.amount / 10).round(2) )
  end
end