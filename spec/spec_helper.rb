require 'bundler/setup'

Bundler.require :default, :test
spec_root = File.expand_path(File.dirname(__FILE__))


$: << spec_root

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

require File.join(File.dirname(__FILE__), '..', 'lib','opsource_client')

Dir[File.join(spec_root, "support/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec, :stdlib
  config.extend VCR::RSpec::Macros
end
