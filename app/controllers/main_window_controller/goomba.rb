class MainWindowController
  class Goomba < MainWindowController::Enemy
    protected
      def clicked!
        @animation.stop
        display_sprite @squashed
        timer(3) {remove!}
      end
      
      def reset_sprites
        @sprites = ['main/goomba-1.png', 'main/goomba-2.png']
        @squashed = 'main/goomba-3.png'
      end
  end
end
