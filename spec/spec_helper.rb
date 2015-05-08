require 'rspec'
require 'rspec/mocks'
require 'rspec/expectations'
require 'faker'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smart_aleck'

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.before(:each) do
    [FakeModel, Entry, Category, User].map(&:destroy_all)
  end
end
