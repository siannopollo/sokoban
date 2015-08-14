class MainWindowController
  class Spiny < MainWindowController::Enemy
    protected
      def clicked!
      end
      
      def reset_sprites
        @sprites = ['main/spiny-1.png', 'main/spiny-2.png']
      end
  end
end
