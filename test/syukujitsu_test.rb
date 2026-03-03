# frozen_string_literal: true

require "test_helper"

class SyukujitsuTest < Minitest::Test
  def test_include
    assert Syukujitsu.include?(Date.new(2025, 1, 1))
    refute Syukujitsu.include?(Date.new(2025, 1, 2))
  end

  def test_on
    entity = Syukujitsu.on(Date.new(2025, 1, 1))

    assert_instance_of Syukujitsu::Entity, entity
    assert_equal "元日", entity.name

    assert_nil Syukujitsu.on(Date.new(2025, 1, 2))
  end

  def test_name
    assert_equal "元日", Syukujitsu.name(Date.new(2025, 1, 1))
    assert_nil Syukujitsu.name(Date.new(2025, 1, 2))
  end

  def test_between
    entities = Syukujitsu.between(Date.new(2025, 1, 1), Date.new(2025, 3, 31))

    refute_empty entities
    assert entities.all? { |e| e.date >= Date.new(2025, 1, 1) && e.date <= Date.new(2025, 3, 31) }
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
