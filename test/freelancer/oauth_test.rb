require "test_helper"

class OAuthTest < Test::Unit::TestCase
  
  context "oAuth" do
    
    setup do
      @consumer_options = {
        :request_token_path => "/RequestRequestToken/requestRequestToken.xml",
        :authorize_url => "http://www.sandbox.freelancer.com/users/api-token/auth.php",
        :access_token_path => "/RequestAccessToken/requestAccessToken.xml",
        :scheme => :query_string,
        :http_method => :get,
        :site => "http://api.sandbox.freelancer.com",
      }
    end
    
    should "initialize with consumer token and secret" do
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      freelancer.consumer_token.should == "consumer_token"
      freelancer.consumer_secret.should == "consumer_secret"
      
    end
    
    should "set request token path to '/RequestRequestToken/requestRequestToken.xml' by default" do
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      freelancer.consumer.options[:request_token_path].should == "/RequestRequestToken/requestRequestToken.xml"
  
    end
    
    should "set authorize url to 'http://www.sandbox.freelancer.com/users/api-token/auth.php' by default when in sandbox mode" do
  
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret", :sandbox => true)
      freelancer.consumer.options[:authorize_url].should == "http://www.sandbox.freelancer.com/users/api-token/auth.php"
  
    end
    
    should "set authorize url to 'http://www.freelancer.com/users/api-token/auth.php' by default when in normal mode" do
  
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      freelancer.consumer.options[:authorize_url].should == "http://www.freelancer.com/users/api-token/auth.php"
  
    end
    should "set access token path to '/RequestAccessToken/requestAccessToken.xml' by default" do
  
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      freelancer.consumer.options[:access_token_path].should == "/RequestAccessToken/requestAccessToken.xml"
  
    end
    
    should "have a consumer" do
  
      consumer = mock("oauth consumer")
      OAuth::Consumer.expects(:new).with("consumer_token", "consumer_secret", @consumer_options).returns(consumer)
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret", :sandbox => true)
      freelancer.consumer.should == consumer
  
    end
    
    should "have a request token from the consumer" do
      
      consumer = mock("oauth consumer")
      request_token = mock("request token")
      consumer.expects(:get_request_token).returns(request_token)
      OAuth::Consumer.expects(:new).with("consumer_token", "consumer_secret", @consumer_options).returns(consumer)
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret", :sandbox => true)
      freelancer.request_token.should == request_token
  
    end
    
    should "clear request token and set the callback url" do
      
      consumer = mock("oauth consumer")
      request_token = mock("request token")
      OAuth::Consumer.expects(:new).with("consumer_token", "consumer_secret", @consumer_options).returns(consumer)
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret", :sandbox => true)
      consumer.expects(:get_request_token).with({ :oauth_callback => "http://foo.bar.com/oauth_callback" })
      freelancer.set_callback_url("http://foo.bar.com/oauth_callback")
      
    end
    
    should "be able to create access token from request token, request secret and verifier" do

      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      freelancer.stubs(:consumer).returns(consumer)
      
      access_token = mock("access_token", :token => "access_token", :secret => "access_secret")
      request_token = mock("request token")
      request_token.expects(:get_access_token).with(:oauth_verifier => "verifier").returns(access_token)
      OAuth::RequestToken.expects(:new).with(consumer, "request_token", "request_secret").returns(request_token)
      
      freelancer.authorize_from_request("request_token", "request_secret", "verifier")
      freelancer.access_token.token.should == "access_token"
      freelancer.access_token.secret.should == "access_secret"
      
    end
    
    should "be able to create access token from access token and secret" do
      
      freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      freelancer.stubs(:consumer).returns(consumer)
      
      freelancer.authorize_from_access("access_token", "access_secret")
      freelancer.access_token.token.should == "access_token"
      freelancer.access_token.secret.should == "access_secret"
      
    end

  end

end
