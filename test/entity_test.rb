# frozen_string_literal: true

require "test_helper"

class EntityTest < Minitest::Test
  def test_attributes
    entity = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")

    assert_equal Date.new(2025, 1, 1), entity.date
    assert_equal "元日", entity.name
  end

  def test_comparable_sort
    new_year = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")
    seijin = Syukujitsu::Entity.new(date: Date.new(2025, 1, 13), name: "成人の日")
    kenkoku = Syukujitsu::Entity.new(date: Date.new(2025, 2, 11), name: "建国記念の日")

    sorted = [kenkoku, new_year, seijin].sort

    assert_equal [new_year, seijin, kenkoku], sorted
  end

  def test_comparable_operators
    earlier = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")
    later = Syukujitsu::Entity.new(date: Date.new(2025, 1, 13), name: "成人の日")

    assert_operator earlier, :<, later
    assert_operator later, :>, earlier
  end

  def test_to_s
    entity = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")

    assert_equal "2025-01-01 元日", entity.to_s
  end

  def test_inspect
    entity = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")

    assert_equal "#<Syukujitsu::Entity 2025-01-01 元日>", entity.inspect
  end

  def test_frozen
    entity = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日").freeze

    assert_predicate entity, :frozen?
  end

  def test_equality
    a = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")
    b = Syukujitsu::Entity.new(date: Date.new(2025, 1, 1), name: "元日")

    assert_equal a, b
  end
end
