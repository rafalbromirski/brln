#!/usr/bin/env ruby

require 'csv'
require 'json'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# if ARGV.size != 2
#   puts 'Usage: csv_to_json input_file.csv output_file.json'
#   puts 'This script uses the first line of the csv file as the keys for the JSON properties of the objects'
#   exit(1)
# end

categories = ARGV.map do |file|
  _lines = CSV.open(file).readlines

  _categoryColumns = _lines[0]
  _categoryLines = _lines[1]
  # remove category content
  _lines.shift(3)

  # core / parsing

  _columns = _lines.delete _lines.first

  places = _lines.map do |values|
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

  category = {
    categoryName: _categoryLines[0],
    categoryDescription: _categoryLines[1],
    places: places
  }
end

db = {
  version: 1.0,
  data: categories
}

File.open('data.json', 'w') do |f|
  f.puts JSON.pretty_generate(db)
end
