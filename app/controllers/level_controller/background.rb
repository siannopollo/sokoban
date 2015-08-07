class LevelController
  class Background < LevelController::Component
    def render
      background_path = image_path 'background.png'
      dimensions = imagesize background_path
      offset = height - dimensions.last
      background background_path, width: dimensions.first, height: dimensions.last, top: offset
    end
  end
end
