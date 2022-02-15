# frozen_string_literal: true

puts "PDF::Core specs: Running on Ruby Version: #{RUBY_VERSION}"

require 'bundler'
Bundler.setup

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'prawn'
require_relative '../lib/prawn/templates'

require 'rspec'
require 'pdf/reader'
require 'pdf/inspector'

RSpec::Matchers.define :have_parseable_xobjects do
  match do |actual|
    expect { PDF::Inspector::XObject.analyze(actual.render) }.to_not raise_error
    true
  end
  failure_message_for_should do |actual|
    "expected that #{actual}'s XObjects could be successfully parsed"
  end
end
