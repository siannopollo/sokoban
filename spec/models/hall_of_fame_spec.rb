require_relative '../spec_helper'

describe HallOfFame do
  let(:model) {HallOfFame.instance}
  
  it 'should not have any entries' do
    model.entries(1).size.should == 0
  end
  
  it 'should add an entry' do
    entry = model.entries(1).add_entry name: 'Fred', time: 68, moves: 204
    
    entry.name.should == 'Fred'
    entry.time.should == 68
    entry.moves.should == 204
    entry.id.should_not be_nil
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
    entry = model.entries(1).add_entry time: 68, moves: 204
    filename = HallOfFame.instance.store_filename
    
    Marshal.load(File.read(filename), &:inspect).inspect.should_not match(/Carlos/)
    
    entry.name = 'Carlos'
    entry.name.should == 'Carlos'
    Marshal.load(File.read(filename), &:inspect).inspect.should match(/Carlos/)
  end
  
  it 'should properly test equality between entries' do
    entry = model.entries(1).add_entry name: 'Art', time: 67, moves: 203
    other = model.entries(1).add_entry name: 'Tar', time: 68, moves: 204
    
    entry.should == entry
    other.should == other
    entry.should_not == other
    
    found_entry = model.entries(1).first
    found_other = model.entries(1).to_a.last
    
    found_entry.should == entry
    found_other.should == other
    found_entry.should_not == found_other
  end
  
  it 'should not have trouble comparing entries' do
    model.store_filename = File.expand_path(File.dirname(__FILE__) + '/.error-hall-of-fame')
    collection = model.entries 1
    -> {collection.to_a}.should_not raise_error
  end
end
