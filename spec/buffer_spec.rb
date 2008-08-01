require File.dirname(__FILE__) + '/spec_helper.rb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'godwit')

describe 'Godwit::Buffer' do
  
  before do
    Kernel.stub!(:print).and_return(nil)
    Kernel.stub!(:puts).and_return(nil)
  end
  
  it "should be '' at the first time it's accessed" do
    Godwit::Buffer.buffer.should == ''
  end
  
  it "should allow the buffer to be set with =" do
    Godwit::Buffer.buffer='blah'
    Godwit::Buffer.buffer.should == 'blah'
  end
  
  it "should allow the buffer to be cleared" do
    Godwit::Buffer.buffer = "blah"
    Godwit::Buffer.clear
    Godwit::Buffer.buffer.should == ''
  end
  
  it "should print to the screen with #print" do
    Kernel.should_receive(:print).with('blah')
    Godwit::Buffer.print('blah')
  end
  
  it "should store the value in the buffer when calling #print" do
    Godwit::Buffer.print('blah')
    Godwit::Buffer.buffer.should == 'blah'
  end
  
  it "should print to the screen with #puts" do
    Kernel.should_receive(:puts).with('blah')
    Godwit::Buffer.puts('blah')
  end
  
  it "should store the value in the buffer when calling #puts" do
    Godwit::Buffer.puts('blah')
    Godwit::Buffer.buffer.should == "blah\n"
  end
  
  after do
    Godwit::Buffer.clear
  end
  
end