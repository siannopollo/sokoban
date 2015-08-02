class Level
  concerned_with :template, :coordinated, :row, :object, :space
  
  attr_reader :rows, :template, :pawn
  attr_reader :boxes, :spaces
  
  delegate :height, :width, to: :template
  
  def initialize(template)
    @template = template
    @rows = template.rows.dup
    
    @pawn = @rows.detect(&:pawn).pawn
    @spaces = @rows.map(&:spaces).flatten
    @boxes = @rows.map(&:boxes).flatten
    @targets = @spaces.select(&:target?)
  end
  
  def move(direction, target = pawn)
    new_coordinates = target.simulate_move direction
    space = @spaces.detect {|s| s.coordinates == new_coordinates}
    return :blocked if space.wall?
    
    box = @boxes.detect {|b| b.coordinates == new_coordinates}
    if box
      result = move direction, box
      return result if result == :blocked
    end
    
    target.move direction
    :moved
  end
  
  def solved?
    @boxes.map(&:coordinates).sort == @targets.map(&:coordinates).sort
  end
end
