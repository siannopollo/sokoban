class MainWindowController
  class Goomba < BaseController::Component
    def render
      @element = flow height: @dimensions[0], width: @dimensions[1], top: height - 2*n, left: width do
        background image_path(@sprites[0])
        click {squash!}
      end
      
      animate!
    end
    
    protected
      def animate!
        @animation = animate 20 do |i|
          new_left = @element.left - 1
          
          if new_left < (n*-1)
            remove!
            next
          end
          
          @element.left = new_left
          
          @counter = i.divmod(4)[0]
          if @counter != @old_counter
            sprite = @sprites.shift
            @element.clear
            @element.background image_path(sprite)
            
            @sprites << sprite
            @old_counter = @counter
          end
        end
      end
      
      def reset
        @counter, @old_counter = nil
        @sprites = ['main/goomba-1.png', 'main/goomba-2.png']
        @squashed = 'main/goomba-3.png'
        @dimensions = imagesize image_path(@sprites.first)
      end
      
      def remove!(&block)
        @animation.stop
        block.call if block
        timer(3) {
          @element.remove
          trigger 'enemy:removed'
        }
      end
      
      def squash!
        remove! do
          @element.clear
          @element.background image_path(@squashed)
        end
      end
  end
end
