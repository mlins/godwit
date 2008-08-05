require File.dirname(__FILE__) + '/spec_helper.rb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'godwit')

describe 'Godwit::Callbacks' do

  before do
    Godwit::Config.setup
    Godwit::Config[:silence] = true
    Godwit::Bootloader.stub!(:boot).and_return(nil)
    @godwit = Godwit::Base.new
    @godwit.stub!(:run_all).and_return(nil)
  end

  it "should call #before_run" do
    @godwit.should_receive(:before_run).once
    @godwit.run
  end
  
  it "should call #after_run" do
    @godwit.should_receive(:after_run).once
    @godwit.run
  end
  
  after do
    Godwit::Config.configuration = nil
  end

end