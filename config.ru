Bundler.require
require File.join(File.dirname(__FILE__), 'app.rb')

run Rack::URLMap.new('/' => MangaStreamer::App)
