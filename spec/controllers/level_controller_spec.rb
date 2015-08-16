require_relative '../spec_helper'
require_relative '../helpers/fake_shoes'

describe LevelController do
  include Shoes::SpecHelpers
  
  let(:model) {LevelController.new basic_template}
  let(:level) {model.level}
  
  before do
    model.run!
  end
  
  it 'should forward moves onto the level' do
    level.moves.should == 0
    level.pawn.coordinates.should == [4,4]
    
    press_key :up
    level.moves.should == 1
    level.pawn.coordinates.should == [4,3]
  end
  
  it 'should complete the game and add an entry to the hall of fame' do
    hall_of_fame = HallOfFame.instance
    hall_of_fame.entries(1).size.should == 0
    
    level.stub(:solved?).and_return true
    
    press_key :down
    hall_of_fame.entries(1).size.should == 1
    entry = hall_of_fame.entries(1).first
    entry.moves.should == 1
    entry.time.should == 1
    entry.name.should == nil
    
    "bob\n".split('').each {|k| press_key k}
    
    hall_of_fame.entries(1).size.should == 1
    entry = hall_of_fame.entries(1).first
    entry.moves.should == 1
    entry.time.should == 1
    entry.name.should == 'bob'
  end
  
  it 'should reset the level' do
    press_key :down
    press_key :up
    press_key :left
    
    level.moves.should == 3
    level.pawn.coordinates.should == [3,4]
    
    perform_click
    level.moves.should == 0
    level.pawn.coordinates.should == [4,4]
  end
end
