module ActionController
  class Base
    
    cattr_accessor :prune_routes
    self.prune_routes = false    
    
    class << self
      
      def actions
        ( instance_methods(false) - hidden_instance_methods ).map{|a| a.to_sym }.to_set
      end
      
      protected
      
      def hidden_instance_methods
        ( protected_instance_methods(false) + private_instance_methods(false) )
      end

    end
    
  end  
end