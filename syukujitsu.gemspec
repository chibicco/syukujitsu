# frozen_string_literal: true

require_relative "lib/syukujitsu/version"

Gem::Specification.new do |spec|
  spec.name = "syukujitsu"
  spec.version = Syukujitsu::VERSION
  spec.authors = ["chibicco"]
  spec.email = ["me@chibicco.dev"]

  spec.summary = "内閣府が公開する「国民の祝日」データを提供する gem"
  spec.description = "内閣府が公開する CSV を基に、日本の祝日データを Enumerable なインターフェースで扱います。"
  spec.homepage = "https://github.com/chibicco/syukujitsu"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    Dir["{lib,exe}/**/*", "holidays.csv", "LICENSE.txt"]
  end
  spec.bindir = "exe"
  spec.executables = ["syukujitsu"]
  spec.require_paths = ["lib"]

  spec.add_dependency "csv", "~> 3.0"
end
