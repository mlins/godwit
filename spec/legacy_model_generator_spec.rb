require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'LegacyModelGenerator' do
  
  include GeneratorSpecHelper
  
  before do
    source = RubiGen::PathSource.new(:component, File.join(File.dirname(__FILE__), "../godwit_generators"))
    RubiGen::Base.reset_sources
    RubiGen::Base.prepend_sources source
    @generator = RubiGen::Scripts::Generate.new
  end
  
  it "should generate a legacy model in the legacy models directory" do
    silence_generator { @generator.run(['blah'], :generator => 'legacy_model') }
    File.file?(File.join(APP_ROOT, 'app', 'models', 'legacy', 'blah.rb')).should be_true
  end
  
  after do
    FileUtils.rm_rf(File.join(APP_ROOT, 'app'))
  end
  
end