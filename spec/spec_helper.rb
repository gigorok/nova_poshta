$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nova_poshta'
require 'webmock/rspec'

WebMock.disable_net_connect!

def read_fixture_file(filename)
  File.read("spec/fixtures/#{filename}")
end

# require support files
require_relative 'support/with_api_key'