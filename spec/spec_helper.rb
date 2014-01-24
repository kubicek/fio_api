$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'fio_api'
require 'webmock'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

FioAPI.token = "somelongtoken"

WebMock::API.stub_request(:any, /fio.cz/).to_return(:status => [401, "Forbidden"])

RSpec.configure do |config|

end
