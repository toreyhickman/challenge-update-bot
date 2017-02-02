require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
Dir[APP_ROOT.join("spec/support/**/*.rb")].each { |f| require f }

require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RequestMacros
end

def app
  Sinatra::Application
end
