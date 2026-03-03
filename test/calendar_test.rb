# frozen_string_literal: true

require "test_helper"

class CalendarTest < Minitest::Test
  include HolidayAssertions

  def setup
    @calendar = Syukujitsu::Calendar.load
  end

  def test_enumerable
    assert_kind_of Enumerable, @calendar
  end

  def test_each_yields_entities
    entities = []
    @calendar.each { |e| entities << e }

    assert entities.all? { |e| e.is_a?(Syukujitsu::Entity) }
    refute_empty entities
  end

  def test_select
    entities_2025 = @calendar.select { |e| e.date.year == 2025 }

    assert entities_2025.all? { |e| e.date.year == 2025 }
    refute_empty entities_2025
  end

  def test_count
    assert_operator @calendar.count, :>, 0
  end

  def test_holiday_contract
    assert_holiday_contract(
      @calendar,
      holiday_date: Date.new(2025, 1, 1),
      non_holiday_date: Date.new(2025, 1, 2),
      holiday_name: "元日"
    )
  end

  def test_on_substitute_holiday
    entity = @calendar.on(Date.new(2025, 2, 24))

    assert_equal "休日", entity.name
  end

  def test_between_contract
    assert_between_contract(
      @calendar,
      start_date: Date.new(2025, 1, 1),
      end_date: Date.new(2025, 3, 31)
    )
  end

  def test_between_empty_range
    entities = @calendar.between(Date.new(2025, 12, 26), Date.new(2025, 12, 31))

    assert_empty entities
  end

  def test_accepts_datetime
    dt = DateTime.new(2025, 1, 1, 12, 0, 0)

    assert @calendar.holiday?(dt)
    assert_equal "元日", @calendar.on(dt).name
    assert_equal "元日", @calendar.name(dt)
  end

  def test_accepts_time
    time = Time.new(2025, 1, 1, 12, 0, 0)

    assert @calendar.holiday?(time)
    assert_equal "元日", @calendar.on(time).name
    assert_equal "元日", @calendar.name(time)
  end

  def test_between_accepts_datetime
    assert_between_contract(
      @calendar,
      start_date: DateTime.new(2025, 1, 1, 0, 0, 0),
      end_date: DateTime.new(2025, 3, 31, 23, 59, 59)
    )
  end

  def test_between_accepts_time
    assert_between_contract(
      @calendar,
      start_date: Time.new(2025, 1, 1, 0, 0, 0),
      end_date: Time.new(2025, 3, 31, 23, 59, 59)
    )
  end

  def test_entities_are_frozen
    entity = @calendar.on(Date.new(2025, 1, 1))

    assert_predicate entity, :frozen?
  end
end
