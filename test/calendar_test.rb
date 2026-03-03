# frozen_string_literal: true

require "test_helper"

class CalendarTest < Minitest::Test
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

  def test_holiday
    assert @calendar.holiday?(Date.new(2025, 1, 1))
    refute @calendar.holiday?(Date.new(2025, 1, 2))
  end

  def test_on
    entity = @calendar.on(Date.new(2025, 1, 1))

    assert_instance_of Syukujitsu::Entity, entity
    assert_equal "元日", entity.name

    assert_nil @calendar.on(Date.new(2025, 1, 2))
  end

  def test_name
    assert_equal "元日", @calendar.name(Date.new(2025, 1, 1))
    assert_nil @calendar.name(Date.new(2025, 1, 2))
  end

  def test_on_substitute_holiday
    entity = @calendar.on(Date.new(2025, 2, 24))

    assert_equal "休日", entity.name
  end

  def test_between
    entities = @calendar.between(Date.new(2025, 1, 1), Date.new(2025, 3, 31))

    refute_empty entities
    assert entities.all? { |e| e.date >= Date.new(2025, 1, 1) && e.date <= Date.new(2025, 3, 31) }
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
    entities = @calendar.between(DateTime.new(2025, 1, 1, 0, 0, 0), DateTime.new(2025, 3, 31, 23, 59, 59))

    refute_empty entities
    assert entities.all? { |e| e.date >= Date.new(2025, 1, 1) && e.date <= Date.new(2025, 3, 31) }
  end

  def test_between_accepts_time
    entities = @calendar.between(Time.new(2025, 1, 1, 0, 0, 0), Time.new(2025, 3, 31, 23, 59, 59))

    refute_empty entities
    assert entities.all? { |e| e.date >= Date.new(2025, 1, 1) && e.date <= Date.new(2025, 3, 31) }
  end

  def test_entities_are_frozen
    entity = @calendar.on(Date.new(2025, 1, 1))

    assert_predicate entity, :frozen?
  end
end
