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
  
  describe 'basics' do
    let(:level) {Level::Parser.new.parse basic_template}
    
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
        specify 'walls' do
          row.walls.size.should == 4
        end
        
        specify 'empty spaces' do
          row.empties.size.should == 3
        end
        
        specify 'target spaces' do
          row.targets.size.should == 1
        end
        
        specify 'objects' do
          row.objects.size.should == 2
        end
        
        specify 'boxes' do
          row.boxes.size.should == 1
        end
        
        specify 'pawns' do
          row.pawn.should_not be_nil
        end
      end
    end
  end
end
