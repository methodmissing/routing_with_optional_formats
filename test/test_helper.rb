require 'init'
require 'test/unit'

$:.unshift(File.dirname(__FILE__)) 

ActionController::Base.optimise_named_routes = true

load( 'routes.rb' )

%w(articles blogs).each{|c| require "subjects/#{c}_controller"  }