ENV['RACK_ENV'] ||= 'development'
# Require gems
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# Require directories and files
Dir[File.dirname(__FILE__) + '/lib/*.rb'].sort.each {|file| require file}
Dir[File.dirname(__FILE__) + '/config/*.rb'].sort.each {|file| require file}

module MangaStreamer
  class App < Sinatra::Base
    get '/status' do
      'App is up and running'
    end

    register MangaRoutes
  end
end
