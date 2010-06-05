module Freelancer
  class Client
    
    extend API
    
    # Load the different API plugins
    api API::User
    api API::Job
    api API::Profile
    
    attr_reader :consumer_token, :consumer_secret, :consumer_options
    
    # Initialize a new Freelancer API client
    def initialize(consumer_token, consumer_secret, consumer_options = {})
      
      default_options = {
        :request_token_path => "/RequestRequestToken/requestRequestToken.xml",
        :authorize_url => "http://www.sandbox.freelancer.com/users/api-token/auth.php",
        :access_token_path => "/RequestAccessToken/requestAccessToken.xml",
        :scheme => :query_string,
        :http_method => :get
      }
      
      @consumer_token, @consumer_secret, @consumer_options = consumer_token, consumer_secret, consumer_options.merge(default_options)
      @api_endpoint = "http://api.sandbox.freelancer.com"

    end
    
    # Get the current oAuth consumer instance
    def consumer
      @consumer ||= ::OAuth::Consumer.new(consumer_token, consumer_secret, { :site => @api_endpoint }.merge(consumer_options))
    end
    
    # Set the callback URL for an oAuth request
    def set_callback_url(url)
      clear_request_token
      request_token :oauth_callback => url
    end
    
    # Get the current oAuth request token
    def request_token(options = {})
      @request_token_instance ||= consumer.get_request_token(options)
    end
    
    # Authorize a user from an oAuth request
    def authorize_from_request(request_token, request_secret, verifier)
      
      request_token = ::OAuth::RequestToken.new(consumer, request_token, request_secret)
      access_token = request_token.get_access_token(:oauth_verifier => verifier)
      @access_token, @access_secret = access_token.token, access_token.secret

    end
    
    # Get the current oAuth access token
    def access_token
      @access_token_instance ||= ::OAuth::AccessToken.new(consumer, @access_token, @access_secret)
    end
    
    # Authorize a user from an oAuth access token
    def authorize_from_access(access_token, access_secret)
      @access_token, @access_secret = access_token, access_secret
    end
    
    # Execute a GET-request for the specified API method
    def api_get(method, options = {})
      response = access_token.get(to_uri(method, options))
      raise_api_errors!(response)
      Crack::JSON.parse(response.body)
    end
    
    # Execute a GET-requset for the specified API method and return the raw
    # result.
    def api_get_raw(method, options = {})
      response = access_token.get(to_uri(method, options))
      raise_api_errors!(response)
      response.body
    end
    
    private
    
    # Clear the current oAuth request token
    def clear_request_token
      @request_token_instance = nil
    end
    
    # Raise an error for the specified API method response if any
    def raise_api_errors!(response)
      
      case response.code.to_i
      when 1..199
        raise "Response code #{response.code}: #{response}"
      when 201..503
        raise "Response code: #{response.code}: #{response}"
      end
      
    end
    
    # Create a URI from the specified method and options
    def to_uri(method, options)
      
      uri = URI.parse(method)
      unless options.nil? || options.empty?
        uri.query = to_query(options)
      end
      
      return uri.to_s
      
    end
    
    # Convert a hash to a proper query string
    def to_query(params)
      params.inject([]) do |collection, options|
        collection << "#{options[0]}=#{options[1]}"
        collection
      end * "&"
    end
    
  end
end