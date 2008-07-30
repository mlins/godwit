require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'MigrationGenerator' do
  
  include GeneratorSpecHelper
  
  before do
    source = RubiGen::PathSource.new(:component, File.join(File.dirname(__FILE__), "../generators"))
    RubiGen::Base.reset_sources
    RubiGen::Base.prepend_sources source
    @generator = RubiGen::Scripts::Generate.new
  end
  
  it "should generate a migration in the migrations directory" do
    silence_generator { @generator.run(['blah', '1', '2'], :generator => 'migration') }
    File.file?(File.join(APP_ROOT, 'app', 'migrations', 'blah_migration.rb')).should be_true
  end
  
  after do
    FileUtils.rm_rf(File.join(APP_ROOT, 'app'))
  end
  
end