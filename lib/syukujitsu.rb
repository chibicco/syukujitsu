# frozen_string_literal: true

require "forwardable"
require_relative "syukujitsu/version"
require_relative "syukujitsu/entity"
require_relative "syukujitsu/calendar"

module Syukujitsu
  class << self
    extend Forwardable
    include Enumerable

    def_delegators :calendar, :each, :holiday?, :on, :name, :between

    private

    def calendar
      @calendar ||= Calendar.load
    end
  end
end
