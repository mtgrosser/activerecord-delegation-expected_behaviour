$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'debug'

require 'activerecord-delegation-expected_behaviour'

ENV["RAILS_ENV"] = "test"

require 'pathname'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

require_relative 'schema'
require_relative 'models/foo'
require_relative 'models/bar'

require 'minitest/autorun'
