class MainWindowController
  class Enemy < BaseController::Component
    def render
      @element = flow({
        width: @dimensions[0], height: @dimensions[1],
        top: height - n - @dimensions[1], left: width
      }) do
        background image_path(@sprites[0])
        click {clicked!}
      end
      
      animate!
    end
    
    protected
      def advance(frame, offset = 1, sprites = @sprites)
        @element.left = @element.left - offset
        
        @counter = frame.divmod(4)[0]
        if @counter != @old_counter
          sprite = sprites.shift
          display_sprite sprite
          sprites << sprite
          
          @old_counter = @counter
        end
      end
      
      def animate!
        @animation = animate 20 do |i|
          advance i
          remove! if offscreen?
        end
      end
      
      def clicked!
        raise NotImplementedError.new
      end
      
      def display_sprite(sprite)
        @element.clear
        @element.background image_path(sprite)
      end
      
      def offscreen?
        @element.left < (@dimensions[0]*-1)
      end
      
      def remove!
        @animation.stop
        @element.remove
        trigger 'enemy:removed'
      end
      
      def reset
        @counter, @old_counter = nil
        @hidden, @emerging, @sliding = false, false, false
        
        reset_sprites
        @dimensions = imagesize image_path(@sprites.first)
      end
      
      def reset_sprites
        raise NotImplementedError.new
      end
  end
end
