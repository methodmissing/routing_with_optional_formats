module ActionController
  class Base
    
    class << self
      
      def actions
        ( instance_methods(false) - _hidden_actions() ).map{|a| a.to_sym }
      end
            
      private
      
      def _hidden_actions
        protected_instance_methods(false) + private_instance_methods(false)
      end      
            
    end
    
  end  
end