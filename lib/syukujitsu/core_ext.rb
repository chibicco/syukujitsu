# frozen_string_literal: true

require "date"
require_relative "../syukujitsu"

class Date
  def holiday?
    Syukujitsu.holiday?(self)
  end

  def holiday_name
    Syukujitsu.name(self)
  end
end
