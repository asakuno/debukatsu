# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require "open-uri"

user = User.find_by(name: 'Admin', role: 2)

CSV.foreach('db/onigiri.csv', headers: true) do |row|
  Food.create!(
    food_name: row['food_name'],
    image: URI.open(row['Image']),
    price: row['Price'],
    calorie: row['calorie'],
    tag_list: row['tag'].split(','),
    user_id: user.id
  )
end

CSV.foreach('db/rice.csv', headers: true) do |row|
  Food.create!(
    food_name: row['food_name'],
    image: URI.open(row['Image']),
    price: row['Price'],
    calorie: row['calorie'],
    tag_list: row['tag'].split(','),
    user_id: user.id
  )
end