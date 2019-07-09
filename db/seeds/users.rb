# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# Setup Users
csv_text = File.read('dbseed-users.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  row_hash = row.to_hash
  row_hash[:password] = 'password'
  row_hash[:password_confirmation] = 'password'
  puts row_hash
  User.create!(row_hash) unless User.where(id: row_hash['id']).count != 0
end
