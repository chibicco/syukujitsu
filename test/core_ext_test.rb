# frozen_string_literal: true

require "test_helper"
require "syukujitsu/core_ext"

class CoreExtTest < Minitest::Test
  def test_holiday_true
    assert Date.new(2025, 1, 1).holiday?
  end

  def test_holiday_false
    refute Date.new(2025, 1, 2).holiday?
  end

  def test_holiday_name
    assert_equal "元日", Date.new(2025, 1, 1).holiday_name
  end

  def test_holiday_name_returns_nil
    assert_nil Date.new(2025, 1, 2).holiday_name
  end
end
