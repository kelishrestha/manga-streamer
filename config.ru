require File.join(File.dirname(__FILE__), 'app.rb')

set :environment, :development
set :run, false
set :raise_errors, true

run Rack::URLMap.new('/' => MangaStreamer::App)
