require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'ActiveModelGenerator' do
  
  include GeneratorSpecHelper
  
  before do
    source = RubiGen::PathSource.new(:component, File.join(File.dirname(__FILE__), "../generators"))
    RubiGen::Base.reset_sources
    RubiGen::Base.prepend_sources source
    @generator = RubiGen::Scripts::Generate.new
  end
  
  it "should generate an active model" do
    silence_generator { @generator.run(['blah'], :generator => 'active_model') }
    File.file?(File.join(APP_ROOT, 'app', 'models', 'blah.rb')).should be_true
  end
  
  after do
    FileUtils.rm_rf(File.join(APP_ROOT, 'app'))
  end
  
end