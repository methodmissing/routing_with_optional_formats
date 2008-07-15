module ActionController
  class Base
    
    cattr_accessor :prune_routes
    self.prune_routes = false    
    
    class << self
      
      def actions
        action_methods.map{|a| a.to_sym }
      end

    end
    
  end  
end