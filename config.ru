require 'rubygems' unless defined? ::Gem
$LOAD_PATH.push File.dirname( __FILE__ ) + '/lib'
require File.dirname( __FILE__ ) + '/app'

run Sinatra::Application
