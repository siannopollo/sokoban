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
        
        if object.box?
          name = 'box.png'
          name = 'box-on-target.png' if level.box_on_target?(object)
        end
        
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
            trigger 'move:successful'
            
            result.objects.each do |object|
              if object.pawn? && [:left, :right].include?(direction)
                rerender_object object, direction
              elsif object.box? && level.box_on_target?(object)
                rerender_object object, direction
                trigger 'level:solved' if level.solved?
              else
                element = @elements[object]
                element.style top: (object.y+1)*n, left: object.x*n
              end
            end
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
      
      def rerender_object(object, direction)
        element = @elements[object]
        element.remove
        render_object object, direction
      end
      
      def reset
        @elements = {}
        @pawn = level.pawn
      end
  end
end
