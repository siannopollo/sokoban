class MainWindowController
  concerned_with :goomba
  
  class Background < BaseController::Component
    def render
      background rgb(93,147,253)
      
      background_path = image_path 'main/background.png'
      dimensions = imagesize background_path
      offset = height - dimensions.last
      background background_path, width: dimensions.first, height: dimensions.last, top: offset
      
      spawn_enemy
    end
    
    protected
      def spawn_enemy
        type = %w(Goomba).sample
        klass = MainWindowController.const_get type
        enemy = klass.new controller
        enemy.render
      end
  end
end
