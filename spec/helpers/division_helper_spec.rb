require 'spec_helper'

describe DivisionsHelper do
  it 'return difference' do
    helper.difference(3).should == '&uarr; 3'
    helper.difference(0).should == '0'
    helper.difference(-19).should == '&darr; -19'
  end
end
