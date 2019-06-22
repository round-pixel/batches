# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'shoulda-matchers'
require_relative '../main'

RSpec.configure do |config|
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    # Keep as many of these lines as are necessary:
    with.library :active_record
    with.library :active_model
  end
end
