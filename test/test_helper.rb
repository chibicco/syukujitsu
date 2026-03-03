# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "syukujitsu"

require "minitest/autorun"

module HolidayAssertions
  def assert_holiday_contract(target, holiday_date:, non_holiday_date:, holiday_name:)
    assert target.holiday?(holiday_date)
    refute target.holiday?(non_holiday_date)

    entity = target.on(holiday_date)
    assert_instance_of Syukujitsu::Entity, entity
    assert_equal holiday_name, entity.name

    assert_nil target.on(non_holiday_date)
    assert_equal holiday_name, target.name(holiday_date)
    assert_nil target.name(non_holiday_date)
  end

  def assert_between_contract(target, start_date:, end_date:)
    entities = target.between(start_date, end_date)

    refute_empty entities
    assert entities.all? { |e| e.date >= start_date.to_date && e.date <= end_date.to_date }
  end
end
