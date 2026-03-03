# frozen_string_literal: true

require "test_helper"
require "open3"
require "rbconfig"

class RefinementsTest < Minitest::Test
  def test_date_is_not_globally_patched_without_core_ext
    script = <<~RUBY
      require "syukujitsu/refinements/date_methods"
      begin
        Date.new(2025, 1, 1).holiday?
      rescue NoMethodError
        puts "no_method"
      end
    RUBY

    stdout, = run_ruby(script)
    assert_includes stdout, "no_method"
  end

  def test_refinement_adds_methods_in_limited_scope
    script = <<~RUBY
      require "syukujitsu/refinements/date_methods"

      module RefinedContext
        using Syukujitsu::Refinements::DateMethods

        def self.holiday?
          Date.new(2025, 1, 1).holiday?
        end

        def self.holiday_name
          Date.new(2025, 1, 1).holiday_name
        end
      end

      puts RefinedContext.holiday?
      puts RefinedContext.holiday_name
    RUBY

    stdout, = run_ruby(script)
    lines = stdout.lines.map(&:strip)

    assert_equal "true", lines[0]
    assert_equal "元日", lines[1]
  end

  private

  def run_ruby(script)
    stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-Ilib", "-e", script)
    raise "ruby execution failed: #{stderr}" unless status.success?

    [stdout, stderr]
  end
end
