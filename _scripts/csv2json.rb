#!/usr/bin/env ruby

require 'csv'
require 'json'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

if ARGV.size != 2
  puts 'Usage: csv_to_json input_file.csv output_file.json'
  puts 'This script uses the first line of the csv file as the keys for the JSON properties of the objects'
  exit(1)
end

lines = CSV.open(ARGV[0]).readlines

categoryColumns = lines[0]
categoryLines = lines[1]
# remove category content
lines.shift(3)

# core / parsing

columns = lines.delete lines.first

File.open(ARGV[1], 'w') do |f|
  places = lines.map do |values|
    res = {
      placeName: values[0],
      placeDescription: values[1],
      placeUrl: values[2],
      placeAddress: values[3],
      placeLocation: {
        lat: values[4].to_s,
        long: values[5].to_s
      }
    }
  end

  data = {
    categoryName: categoryLines[0],
    categoryDescription: categoryLines[1],
    places: places
  }

  f.puts JSON.pretty_generate(data)
end
