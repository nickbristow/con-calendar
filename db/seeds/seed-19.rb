# frozen_string_literal: true

require 'csv'

# Setup Events
csv_text = File.read('gc19-events.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  row_hash = row.to_hash
  puts row_hash
  Event.create!(row_hash)
end
