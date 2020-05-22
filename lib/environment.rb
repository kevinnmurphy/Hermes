#config/env

#require gems in gemfile
require 'bundler/setup'
Bundler.require(:default)
#Bundler.require(:default, :development)

#require gems
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'net/http'
require 'rake'
require 'dotenv/load'



# require relative paths
require_relative './hermes/version'
require_relative './hermes/cli'
require_relative './hermes/api'
require_relative './hermes/trails'
require_relative './concerns/memorable'

#require_relative "./lib/hermes/location"
#require_relative "./lib/hermes/weather"

module Hermes
  class Error < StandardError; end
  # Your code goes here...
end
