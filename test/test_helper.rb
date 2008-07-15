require 'init'
require 'test/unit'

$:.unshift(File.dirname(__FILE__)) 

ActionController::Base.prune_routes = true
ActionController::Base.optimise_named_routes = true
ActionController::Base.logger = Logger.new( STDOUT )

%w(articles blogs).each{|c| require "subjects/#{c}_controller" }

module Admin
end
require 'subjects/admin/blogs_controller'

load( 'routes.rb' )

def without_pruning
  ActionController::Base.prune_routes = false
  yield
  ActionController::Base.prune_routes = true
end