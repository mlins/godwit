begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

APP_ROOT = File.dirname(__FILE__) + "/../tmp"

module GeneratorSpecHelper
  
  def silence_generator
    logger_original=RubiGen::Base.logger
    myout=StringIO.new
    RubiGen::Base.logger=RubiGen::SimpleLogger.new(myout)
    # TODO redirect $stdout to myout
    yield if block_given?
    RubiGen::Base.logger=logger_original
    # TODO fix $stdout again
    myout.string
  end
  
end