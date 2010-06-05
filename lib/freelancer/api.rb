module Freelancer
  module API
    
    # Returns the list of registered APIs
    def apis
      @apis ||= []
    end
    
    # Include the specified API
    def api(api)
      
      extend api::ClassMethods if api.const_defined?(:ClassMethods)
      include api::InstanceMethods if api.const_defined?(:InstanceMethods)
      
      apis << api
      
    end
    
  end
end