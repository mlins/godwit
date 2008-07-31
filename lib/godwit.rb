$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'rubygems'
require 'active_support'
require 'active_record'
require 'active_migration'

require 'godwit/base'
require 'godwit/bootloader'
require 'godwit/config'
require 'godwit/legacy_record'
require 'godwit/version'

module Godwit
  def self.boot
    Godwit::Bootloader.boot
  end
  def self.migrate
    Godwit::Base.migrate
  end
end

ActiveMigration::Base.class_eval do
  
  def handle_error(model, error_field, error_message)
    puts "********************************************************************"
    begin
      puts "Failed on " + model.id.to_s + " because '" + error_field.to_s + "' " + error_message.to_s
    rescue
      puts "Failed on associated model: #{model.class.to_s} because #{error_field.to_s} #{error_message.to_s}"
    end
    puts "The current value of '#{error_field.to_s}' is: '" + model.instance_eval(error_field).to_s + "'"
    print "Please enter a new value for '#{error_field}': "
    new_value = gets
    puts "********************************************************************"
    new_value.chomp
  end

  def handle_success(model)
    puts "Successfully migrated " + model.id.to_s
  end

end