class Level
  def move(direction, target = pawn)
    return result!(:invalid) unless valid_move?(direction)
    
    new_coordinates = target.simulate_move direction
    space = @spaces.detect {|s| s.coordinates == new_coordinates}
    return blocked! if space.wall?
    
    box = @boxes.detect {|b| b.coordinates == new_coordinates}
    secondary_result = nil
    if box
      return blocked! if target.box?
      
      secondary_result = move direction, box
      return secondary_result if secondary_result.blocked?
    end
    
    target.move direction
    result! :moved, target, secondary_result
  end
  
  protected
    def valid_move?(direction)
      %w(up down left right).include? direction.to_s
    end
  
  module Movement
    concerned_with :result
  end
end
