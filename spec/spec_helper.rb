require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter

SimpleCov.start do
    add_filter 'spec/'
end

require 'pry'
require 'json_kit'
require_relative 'json_kit/test_objects'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = false

  config.profile_examples = 10

  config.order = :defined

  Kernel.srand config.seed
end
