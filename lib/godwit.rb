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
require 'godwit/version'

module Godwit
  def self.boot
    Godwit::Bootloader.boot
  end
  def self.migrate
    Godwit.boot
    Godwit::Buffer.puts "\nLoading Migrations..." unless Godwit::Config[:silence]
    Godwit::Base.migrate
    Godwit::Buffer.puts "\nDone." unless Godwit::Config[:silence]  
  end
end