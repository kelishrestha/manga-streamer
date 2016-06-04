require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'nokogiri'
require File.join(File.dirname(__FILE__), 'app.rb')

set :environment, :development
set :run, false
set :raise_errors, true

run Sinatra::Application
