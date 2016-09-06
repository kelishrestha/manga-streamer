require 'rubygems'
require 'bundler'

module App
  def self.root
    @root_path ||= FileUtils.pwd
  end
end

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

Dir["#{App.root}/app/views/**/*.rb"].sort.each {|file| require_relative(file)}
