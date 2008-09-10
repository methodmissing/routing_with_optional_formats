ActionController::Resources::Resource.class_eval do
  
  DEFAULT_ACTIONS = [:index, :new, :create, :show, :edit, :update, :destroy].to_set
  DEFAULT_SINGLETON_ACTIONS = [:new, :create, :show, :edit, :update, :destroy].to_set
  COLLECTION_ACTIONS = [:index, :create].to_set
  MEMBER_ACTIONS = [:show, :update, :destroy].to_set  

  def controller_klass
    @controller_klass ||= begin
        "#{@controller.camelize}Controller".constantize
      rescue
        "#{@controller.classify}Controller".constantize
      end
  end
  
  def formatted?
    options_with_default( :formatted )
  end  
  
  def actions
    returning( controller_klass.actions ) do |_actions|
      _actions + ( singleton? ? MEMBER_ACTIONS : COLLECTION_ACTIONS )
    end    
  end

  def default_actions
    (singleton? ? DEFAULT_SINGLETON_ACTIONS : DEFAULT_ACTIONS )
  end

  def prune?
    ActionController::Base.prune_routes    
  end
  
  def action?( action )
    actions.include?( action )
  end
  
  def singleton?
    is_a?( ActionController::Resources::SingletonResource )
  end
  
  private

  def options_with_default( key )
    @options.key?(key) ? @options[key] : true 
  end
    
end

ActionController::Resources.module_eval do

  private
    
  def action_options_for_with_formatted( action, resource, method = nil )
    #if resource.action?( action.to_sym )
      returning( action_options_for_without_formatted( action, resource, method = nil ) ) do |action_options|
        action_options.merge!( :formatted => resource.formatted? )
      end
    #else
    #  {}
    #end           
  end    

  alias_method_chain :action_options_for, :formatted
  
end