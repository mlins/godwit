begin
  require 'spec'
  require 'rubigen'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
  require 'rubigen'
end

require 'rubigen/scripts/generate'

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