# frozen_string_literal: true

require "test_helper"
require "tempfile"

class CsvLoaderTest < Minitest::Test
  def test_load_parses_csv_to_frozen_entities_hash
    csv = Tempfile.new(["holidays", ".csv"])
    csv.write("国民の祝日・休日月日,国民の祝日・休日名称\n")
    csv.write("2024/01/01,元日\n")
    csv.write("2024/01/08,成人の日\n")
    csv.flush

    entities = Syukujitsu::CsvLoader.new.load(csv.path)

    assert_predicate entities, :frozen?
    assert_equal [Date.new(2024, 1, 1), Date.new(2024, 1, 8)], entities.keys
    assert_instance_of Syukujitsu::Entity, entities[Date.new(2024, 1, 1)]
    assert_equal "元日", entities[Date.new(2024, 1, 1)].name
    assert_predicate entities[Date.new(2024, 1, 1)], :frozen?
  ensure
    csv.close!
  end

  def test_calendar_load_accepts_loader_injection
    fake_entity = Syukujitsu::Entity.new(date: Date.new(2024, 1, 1), name: "元日").freeze
    fake_loader = Object.new
    fake_loader.define_singleton_method(:load) do |_path|
      { Date.new(2024, 1, 1) => fake_entity }
    end

    calendar = Syukujitsu::Calendar.load(csv_path: "ignored.csv", loader: fake_loader)

    assert_equal "元日", calendar.name(Date.new(2024, 1, 1))
  end
end
