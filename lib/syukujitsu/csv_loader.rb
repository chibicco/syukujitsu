# frozen_string_literal: true

require "csv"
require "date"

module Syukujitsu
  class CsvLoader
    def load(csv_path)
      entities = {}
      CSV.foreach(csv_path, headers: true, encoding: "UTF-8") do |row|
        date = Date.strptime(row[0], "%Y/%m/%d")
        entities[date] = Entity.new(date: date, name: row[1]).freeze
      end
      entities.freeze
    end
  end
end
