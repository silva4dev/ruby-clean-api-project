# frozen_string_literal: true

require 'rack/test'
require 'json'
require 'simplecov'
require_relative '../src/root/server'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.pattern = 'tests/**/*_spec.rb'
  config.include Rack::Test::Methods
  SimpleCov.start if ENV['COVERAGE']

  def app
    Server
  end
end
