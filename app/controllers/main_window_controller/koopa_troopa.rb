class MainWindowController
  class KoopaTroopa < MainWindowController::Enemy
    protected
      def advance(frame, offset = 1)
        if @emerging
          super frame, 0, @emerge_sprites
        else
          super frame, offset
        end
      end
      
      def clicked!
        return if @sliding
        return hide! unless @hidden
        slide!
      end
      
      def hide!
        @animation.stop
        display_sprite @hide_sprite
        @hidden = true
        
        @hide_timer = timer(3) {
          @emerging = true
          @hidden = false
          @animation.start
          timer(2) {
            @emerge_sprites = [@hide_sprite].concat(@emerge_sprites).uniq!
            display_sprite @emerge_sprites.last
            @emerging = false
          }
        }
      end
      
      def reset_sprites
        @sprites = ['main/koopa-troopa-1.png', 'main/koopa-troopa-2.png']
        @hide_sprite = 'main/koopa-troopa-3.png'
        @emerge_sprites = ['main/koopa-troopa-3.png', 'main/koopa-troopa-4.png']
      end
      
      def slide!
        @sliding = true
        
        @animation.stop
        @hide_timer.stop
        
        display_sprite @hide_sprite
        @animation = animate(40) do
          @element.left = @element.left - 10
          remove! if offscreen?
        end
      end
  end
end
