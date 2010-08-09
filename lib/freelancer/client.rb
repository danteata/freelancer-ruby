module Freelancer
  class Client
    
    extend API
    
    # Load the different API plugins
    api API::User
    api API::Job
    api API::Profile
    api API::Employer
    api API::Freelancer
    api API::Common
    api API::Payment
    api API::Notification
    api API::Project
    api API::Message

    attr_reader :consumer_token, :consumer_secret, :consumer_options, :sandbox_mode
    
    # Initialize a new Freelancer API client
    def initialize(consumer_token, consumer_secret, *args)

      options = extract_params(args)
      @sandbox_mode = options.delete(:sandbox) || false

      default_options = {
        :request_token_path => "/RequestRequestToken/requestRequestToken.xml",
        :authorize_url => site_url("/users/api-token/auth.php"),
        :access_token_path => "/RequestAccessToken/requestAccessToken.xml",
        :scheme => :query_string,
        :http_method => :get
      }
      
      @consumer_token, @consumer_secret, @consumer_options = consumer_token, consumer_secret, options.merge(default_options)
      @api_endpoint = api_url
    
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
      return response.body
    end
    
    # Execute a GET-request for the specified API method and return the raw
    # result.
    def api_get_raw(method, options = {})
      response = access_token.get(to_uri(method, options))
      raise_api_errors!(response)
      response.body
    end
    
    private

    # Get the URL to a specific site path
    def site_url(path = "")
      self.sandbox_mode == true ? "http://www.sandbox.freelancer.com#{path}" : "http://www.freelancer.com#{path}"
    end

    # Get the URL to a specific api path
    def api_url(path = "")
      self.sandbox_mode == true ? "http://api.sandbox.freelancer.com#{path}" : "http://api.freelancer.com#{path}"
    end

    # Extract params from an array of arguments. Copied from ActiveSupport.
    def extract_params(args)
      args.last.is_a?(Hash) ? args.last : {}
    end

    # Build a hash of parameters based on the arguments, stripping out any blank
    # arguments.
    def build_api_params(params)
      params.reject { |key, value| value.nil? || value == "" }
    end
    
    # Clear the current oAuth request token
    def clear_request_token
      @request_token_instance = nil
    end
    
    # Raise an error for the specified API method response if any
    def raise_api_errors!(response)
      
      case response.code.to_i
      when 1..199
        raise FreelancerRequestError.new("Got response code #{response.code} when executing API request")
      when 201..503
        raise FreelancerRequestError.new("Got response code #{response.code} when executing API request")
      end

      # Attempt to convert the response to a JSON data structure
      json = JSONMapper::Parser.parse(response.body)

      # If we didn't get a proper response, raise an error
      raise FreelancerResponseError.new("No or invalid response received when executing API request") if json.nil?

      # If the JSON data has an error element as the only element,
      # assume this request fails
      if json.keys.size == 1 && json.keys.first == :errors

        error_code = json[:errors][:error][:code]
        error_message = json[:errors][:error][:msg]
        error_description = json[:errors][:error][:longmsg]

        raise FreelancerResponseError.new("#{error_message} - #{error_description} (code #{error_code})")

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
        options[1] = URI.escape(options[1]) if options[1].is_a?(String) && !options[1].nil?
        collection << "#{options[0]}=#{options[1]}"
        collection
      end * "&"
    end
    
    # Decode any HTML entities in the given string
    def html_decode(str)
      encoder = HTMLEntities.new
      encoder.decode(str)
    end
    
  end
end
