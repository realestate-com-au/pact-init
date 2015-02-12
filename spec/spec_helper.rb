require 'rspec'
require 'byebug'


RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
