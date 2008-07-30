require File.dirname(__FILE__) + '/spec_helper.rb'

require 'rubygems'
require 'rubigen'
require 'rubigen/scripts/generate'

describe 'GodwitGenerator' do
  
  include GeneratorSpecHelper

  before do
    source = RubiGen::PathSource.new(:application, File.join(File.dirname(__FILE__), "../app_generators"))
    RubiGen::Base.reset_sources
    RubiGen::Base.prepend_sources source
    @generator = RubiGen::Scripts::Generate.new
    @test_path = File.join(File.dirname(__FILE__), '..', 'tmp', 'test')
  end

  %w(tmp script log config app/models/legacy app/migrations).each do |dir| 
    it "should create the '#{dir}' directory" do
      silence_generator { @generator.run(['tmp/test'], :generator => 'godwit') }
      File.directory?(File.join(@test_path, dir)).should be_true
    end
  end

  %w(config/database.yml config/environment.rb log/migration.log
  script/console script/migrate script/generate script/destroy script/lib/console.rb).each do |file|
    it "should create the '#{file}' file" do
      silence_generator { @generator.run(['tmp/test'], :generator => 'godwit') }
      File.file?(File.join(@test_path, file)).should be_true
    end
  end

  after do
    FileUtils.rm_rf(@test_path)
  end

end
