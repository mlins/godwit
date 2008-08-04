require File.dirname(__FILE__) + '/spec_helper.rb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'godwit')

describe 'Godwit::Callbacks' do

  it "should call #before_migrate" do
    Godwit::Base.should_receive(:before_migrate).once
    Godwit.migrate
  end
  
  it "should call #after_migrate" do
    Godwit::Base.should_receive(:after_migrate).once
    Godwit.migrate
  end

end