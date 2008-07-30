require File.dirname(__FILE__) + '/spec_helper.rb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'godwit') 

describe 'Godwit::Config' do
  
  before do
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
  
  it "should support -s to skip dependencies" do
    Godwit::Config.parse_args(["-s"])
    Godwit::Config[:skip_dependencies].should be_true
  end
  
end