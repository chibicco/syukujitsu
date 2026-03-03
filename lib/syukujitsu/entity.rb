# frozen_string_literal: true

module Syukujitsu
  Entity = Struct.new(:date, :name, keyword_init: true) do
    include Comparable

    def <=>(other)
      date <=> other.date
    end

    def to_s
      "#{date} #{name}"
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
