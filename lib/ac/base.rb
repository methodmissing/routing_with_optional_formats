module ActionController
  class Base
    
    class << self
      
      def actions
        action_methods.to_a.map{|a| a.to_sym }
      end

    end
    
  end  
end