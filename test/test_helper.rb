require "test/unit"
require "shoulda"
require "matchy"
require "mocha"
require "fakeweb"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "freelancer"

class Test::Unit::TestCase
end

# Read the specified fixture file and return the file contents
def fixture_file(filename)

  return "" if filename == ""
  file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)

  contents = File.read(file_path)
  # encoder = HTMLEntities.new
  # encoder.decode(contents)
  contents

end

# Get the URL for an API method
def api_url(method)
  "http://api.sandbox.freelancer.com:80#{method}"
end

# Create a fake web stub for the specified API GET method
def stub_api_get(method, filename, status = nil)
  stub_api_request(:get, method, filename, status)
end

# Create a fake web stub for the specified method
def stub_api_request(type, method, filename, status = nil)
  options = { :body => fixture_file(filename) }
  options.merge!({ :status => status }) unless status.nil?
  FakeWeb.register_uri(type, api_url(method), options)
end
