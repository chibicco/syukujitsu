# frozen_string_literal: true

require "forwardable"
require_relative "syukujitsu/version"
require_relative "syukujitsu/entity"
require_relative "syukujitsu/calendar"

module Syukujitsu
  class << self
    extend Forwardable
    include Enumerable

    def_delegators :calendar, :each, :on, :name, :between

    def include?(date)
      calendar.holiday?(date)
    end

    private

    def calendar
      @calendar ||= Calendar.load
    end
  end
end
