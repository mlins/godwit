$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'rubygems'
require 'active_support'
require 'active_record'
require 'active_migration'

require 'godwit/active_migration'
require 'godwit/base'
require 'godwit/bootloader'
require 'godwit/buffer'
require 'godwit/config'
require 'godwit/legacy_record'
require 'godwit/irb'
require 'godwit/callbacks'
require 'godwit/version'

Godwit::Base.class_eval do
  include Godwit::Callbacks
end