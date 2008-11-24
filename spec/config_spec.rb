require File.dirname(__FILE__) + '/spec_helper.rb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'godwit') 

describe 'Godwit::Config' do
  
  before do
    Godwit::Config.configuration = nil
    Godwit::Config.setup
  end
  
  it "should be able to yield the configuration via #use" do
    res = nil
    Godwit::Config.use {|c| res = c}
    res.should == Godwit::Config.defaults
  end
  
  it "should be able to get a configuration key" do
    Godwit::Config[:bar] = "foo"
    Godwit::Config[:bar].should == "foo"
  end
  
  it "should be able to delete a configuration key" do
    Godwit::Config[:bar] = "foo"
    Godwit::Config.delete(:bar)
    Godwit::Config[:bar].should be_nil
  end
  
  it "should support -d to debug" do
    Godwit::Config.parse_args(["-D"])
    Godwit::Config[:debug].should be_true
  end
  
  it "should support -s to silence output" do
    Godwit::Config.parse_args(["-s"])
    Godwit::Config[:silence].should be_true
  end
  
  it "should support -d to skip dependencies" do
    Godwit::Config.parse_args(["-d"])
    Godwit::Config[:skip_dependencies].should be_true
  end
  
  it "should support -m to skip migrations" do
    Godwit::Config.parse_args(["-m", "products_migration,manufacturer_migration"])
    Godwit::Config[:skip_migrations].should == ["products_migration","manufacturer_migration"]
  end
  
  it "should support -S to run a specific migration" do
    Godwit::Config.parse_args(['-S', 'products_migration'])
    Godwit::Config[:specific_migration].should == 'products_migration'
  end
  
end