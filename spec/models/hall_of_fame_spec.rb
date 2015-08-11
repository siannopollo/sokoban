require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fileutils'

describe HallOfFame do
  let(:model) {HallOfFame.instance}
  
  before do
    @filename = File.expand_path(File.dirname(__FILE__) + '/.test-hall-of-fame')
    model.store_filename = @filename
  end
  
  after do
    FileUtils.rm_f @filename
    model.instance_variable_set '@store', nil
  end
  
  it 'should not have any entries' do
    model.entries(1).size.should == 0
  end
  
  it 'should add an entry' do
    model.entries(1).add_entry name: 'Fred', time: 68, moves: 204
    
    entry = model.entries(1).first
    entry.name.should == 'Fred'
    entry.time.should == 68
    entry.moves.should == 204
  end
  
  it 'should sort entries by best time/moves combo' do
    model.entries(1).add_entry name: 'Fred', time: 68, moves: 204
    model.entries(1).add_entry name: 'Carl', time: 104, moves: 220
    model.entries(1).add_entry name: 'Mark', time: 90, moves: 171
    
    model.entries(1).map(&:name).should == %w(Mark Fred Carl)
  end
  
  it 'should not grab entries for a different level' do
    model.entries(1).add_entry name: 'Fred', time: 68, moves: 204
    model.entries(1).add_entry name: 'Carl', time: 104, moves: 220
    model.entries(6).add_entry name: 'Mark', time: 90, moves: 171
    
    model.entries(1).size.should == 2
    model.entries(6).size.should == 1
    model.entries(2).size.should == 0
  end
  
  it 'should add an entry, then allow it to be edited but still persisted' do
    pending
  end
end
