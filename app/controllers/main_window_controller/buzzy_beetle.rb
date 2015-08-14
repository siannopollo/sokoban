class MainWindowController
  class BuzzyBeetle < MainWindowController::KoopaTroopa
    protected
      def reset_sprites
        @sprites = ['main/buzzy-beetle-1.png', 'main/buzzy-beetle-2.png']
        @hide_sprite = 'main/buzzy-beetle-3.png'
        @emerge_sprites = ['main/buzzy-beetle-3.png', 'main/buzzy-beetle-4.png']
      end
  end
end
