class LevelController
  class Board < LevelController::Component
    attr_reader :pawn
    
    def render
      level.spaces.each {|s| render_object s}
      level.boxes.each {|b| render_object b}
      render_object pawn
      
      observe_keypress
    end
    
    protected
      def image_for_object(object, direction = nil)
        name = nil
        name = 'wall.png' if object.wall?
        name = 'target.png' if object.target?
        name = 'box.png' if object.box?
        if object.pawn?
          direction ||= :right
          name = "mario-#{direction}.png"
        end
        image_named name if name
      end
      
      def observe_keypress
        keypress do |direction|
          result = level.move direction
          if result.success?
            result.objects.each do |object|
              element = @elements[object]
              element.style top: (object.y+1)*n, left: object.x*n
              
              if object.pawn? && [:left, :right].include?(direction)
                element.remove
                render_object object, direction
              end
            end
            
            trigger 'successful_move'
            trigger 'level_solved' if level.solved?
          end
        end
      end
      
      # Render either a space or an object
      def render_object(object, direction = nil)
        flow top: (object.y+1)*n, left: object.x*n, width: n, height: n do
          image = image_for_object object, direction
          style background: image if image
        end.tap do |element|
          @elements[object] = element
        end
      end
      
      def reset
        @elements = {}
        @pawn = level.pawn
      end
  end
end
