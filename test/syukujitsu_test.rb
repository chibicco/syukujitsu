# frozen_string_literal: true

require "test_helper"

class SyukujitsuTest < Minitest::Test
  include HolidayAssertions

  def test_holiday_contract
    assert_holiday_contract(
      Syukujitsu,
      holiday_date: Date.new(2025, 1, 1),
      non_holiday_date: Date.new(2025, 1, 2),
      holiday_name: "元日"
    )
  end

  def test_between_contract
    assert_between_contract(
      Syukujitsu,
      start_date: Date.new(2025, 1, 1),
      end_date: Date.new(2025, 3, 31)
    )
  end

  def test_enumerable_select
    entities_2025 = Syukujitsu.select { |e| e.date.year == 2025 }

    assert entities_2025.all? { |e| e.date.year == 2025 }
    refute_empty entities_2025
  end

  def test_enumerable_count
    assert_operator Syukujitsu.count, :>, 0
  end

  def test_enumerable_first
    first_three = Syukujitsu.first(3)

    assert_equal 3, first_three.size
    assert first_three.all? { |e| e.is_a?(Syukujitsu::Entity) }
  end

  def test_version
    refute_nil Syukujitsu::VERSION
  end
end
