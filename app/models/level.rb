class Level
  concerned_with :template, :coordinated, :row, :object, :space, :movement
  
  attr_reader :rows, :template, :pawn, :boxes, :spaces, :moves
  
  delegate :height, :width, :number, to: :template
  
  def initialize(template)
    @template = template
    @rows = template.rows_for_level
    
    @pawn = @rows.detect(&:pawn).pawn
    @spaces = @rows.map(&:spaces).flatten
    @boxes = @rows.map(&:boxes).flatten
    @targets = @spaces.select(&:target?)
    
    @moves = 0
  end
  
  def solved?
    @boxes.map(&:coordinates).sort == @targets.map(&:coordinates).sort
  end
end
