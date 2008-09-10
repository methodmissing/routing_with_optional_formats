ActionController::Resources::Resource.class_eval do
  
  DEFAULT_ACTIONS =  [:index, :new, :create, :show, :edit, :update, :destroy].to_set
  DEFAULT_SINGLETON_ACTIONS = [:new, :create, :show, :edit, :update, :destroy].to_set
  COLLECTION_ACTIONS = [:index, :create].to_set
  MEMBER_ACTIONS = [:show, :update, :destroy].to_set  
  
  def controller_klass
    @controller_klass if controller_klass?
  end
  
  def controller_klass?
    begin
      @controller_klass ||= camelized_controller.constantize
    rescue 
      ActionController::Base.logger.info " ** #{camelized_controller} not yet defined.Using default routes."
      false
    end
  end
  
  def formatted?
    options_with_default( :formatted )
  end  
  
  def actions
    ( prune? && controller_klass? ) ? controller_actions : default_actions
  end

  def controller_actions
    returning( controller_klass.actions.dup ) do |ca|
      ca << :show unless ca.difference( MEMBER_ACTIONS ).empty?
      ca << :index unless !uncountable? && ca.difference( COLLECTION_ACTIONS ).empty?
      ca.delete_if{|a| a == :index } if uncountable?
    end
  end
        
  def default_actions
    (uncountable? ? DEFAULT_SINGLETON_ACTIONS : DEFAULT_ACTIONS ).union( custom_actions )
  end

  def custom_actions
    @custom_actions ||= custom_actions_from_ivars.flatten.uniq.to_set
  end

  def prune?
    ActionController::Base.prune_routes    
  end
  
  def action?( action )
    actions.include?( action )
  end
  
  def camelized_controller
    @camelized_controller ||= 
    "#{controller.camelize}Controller"
  end  
  
  def singleton?
    is_a?( ActionController::Resources::SingletonResource )
  end
  
  private
    
  def custom_actions_from_ivars
    [@collection_methods, @member_methods, @new_methods].map{|i| i.values }
  end
  
  def options_with_default( key )
    @options.key?(key) ? @options[key] : true 
  end
    
end

ActionController::Resources.module_eval do

  private
    
  def action_options_for_with_formatted( action, resource, method = nil )
    if resource.action?( action.to_sym )
      returning( action_options_for_without_formatted( action, resource, method = nil ) ) do |action_options|
        action_options.merge!( :formatted => resource.formatted? )
      end
    else
      {}
    end           
  end    

  alias_method_chain :action_options_for, :formatted
  
end