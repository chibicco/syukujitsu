# frozen_string_literal: true

require "date"
require_relative "csv_loader"

module Syukujitsu
  class Calendar
    include Enumerable

    CSV_PATH = File.expand_path("../../holidays.csv", __dir__)

    def self.load(csv_path: CSV_PATH, loader: CsvLoader.new)
      new(loader.load(csv_path))
    end

    def initialize(entities)
      @entities = entities.dup.freeze
      @dates = @entities.keys.sort.freeze
    end

    def each(&)
      @entities.each_value(&)
    end

    def holiday?(date)
      @entities.key?(normalize_date(date))
    end

    def on(date)
      @entities[normalize_date(date)]
    end

    def name(date)
      on(date)&.name
    end

    def between(start_date, end_date)
      s = normalize_date(start_date)
      e = normalize_date(end_date)
      return [] if s > e

      left = @dates.bsearch_index { |d| d >= s }
      return [] if left.nil?

      right = @dates.bsearch_index { |d| d > e }
      selected_dates = right.nil? ? @dates[left..] : @dates[left...right]
      selected_dates.map { |date| @entities[date] }
    end

    private

    def normalize_date(value)
      value.to_date
    end
  end
end
