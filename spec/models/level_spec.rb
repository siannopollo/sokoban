require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Level do
  let(:basic_template) {
    %{
      ###
      #.#
      # ####
    ###o o.#
    #. o@###
    ####o#
       #.#
       ###
    }
  }
  let(:template) {Level::Template.parse basic_template}
  let(:level) {Level.new template}
  
  describe 'template cache' do
    before do
      Level::Template.all.clear
    end
    
    it 'should have one template' do
      Level::Template.all.should be_empty
      
      level
      Level::Template.all.size.should == 1
      Level::Template.all.values.first.should_not be_nil
    end
  end
  
  describe 'basics' do
    it 'should know the dimensions' do
      level.width.should == 8
      level.height.should == 8
    end
    
    it 'should know the rows' do
      level.rows[0].to_s.should == '  ###   '
      level.rows[1].to_s.should == '  #.#   '
      level.rows[2].to_s.should == '  # ####'
      level.rows[3].to_s.should == '###o o.#'
      level.rows[4].to_s.should == '#. o@###'
      level.rows[5].to_s.should == '####o#  '
      level.rows[6].to_s.should == '   #.#  '
      level.rows[7].to_s.should == '   ###  '
    end
    
    describe 'rows' do
      let(:row) {level.rows[4]}
      
      it 'should know the y-index' do
        row.y.should == 4
      end
      
      describe 'numbers of' do
        specify 'spaces' do
          row.spaces.size.should == 8
          row.walls.size.should == 4
          row.empties.size.should == 3
          row.targets.size.should == 1
        end
        
        specify 'objects' do
          row.objects.size.should == 2
          row.boxes.size.should == 1
          row.pawn.should_not be_nil
        end
      end
    end
  end
  
  describe 'movement' do
    let(:pawn) {level.pawn}
    
    before do
      pawn.coordinates.should == [4,4]
    end
    
    it 'should move the pawn up one space' do
      level.move :up
      pawn.coordinates.should == [4,3]
    end
    
    it 'should move the pawn down one space' do
      box = level.boxes.last
      box.coordinates.should == [4,5]
      
      result = level.move :down
      pawn.coordinates.should == [4,5]
      box.coordinates.should == [4,6]
      result.should == :moved
    end
    
    it 'should move the pawn down one space' do
      box = level.boxes[2]
      box.coordinates.should == [3,4]
      
      result = level.move :left
      pawn.coordinates.should == [3,4]
      box.coordinates.should == [2,4]
      result.should == :moved
    end
    
    it 'should move the pawn down one space' do
      result = level.move :right
      pawn.coordinates.should == [4,4]
      result.should == :blocked
    end
    
    it 'should prevent the pawn from moving a box into a wall' do
      level.move :up
      
      box = level.boxes.first
      box.coordinates.should == [3,3]
      
      result = level.move :left
      pawn.coordinates.should == [4,3]
      box.coordinates.should == [3,3]
      result.should == :blocked
    end
  end
  
  describe 'solving' do
    it 'should work' do
      level.should_not be_solved
      
      level.move :down
      level.should_not be_solved
      
      level.move :up
      level.move :left
      level.move :left
      level.should_not be_solved
      
      level.move :right
      level.move :up
      level.move :up
      level.should_not be_solved
      
      level.move :down
      level.move :right
      level.move :right
      level.should be_solved
    end
  end
end
