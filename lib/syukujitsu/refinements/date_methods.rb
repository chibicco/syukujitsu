# frozen_string_literal: true

require "date"
require_relative "../../syukujitsu"

module Syukujitsu
  module Refinements
    module DateMethods
      refine Date do
        def holiday?
          Syukujitsu.holiday?(self)
        end

        def holiday_name
          Syukujitsu.name(self)
        end
      end
    end
  end
end
