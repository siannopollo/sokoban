class LevelController
  include Observable
  
  concerned_with :component, :board, :toolbar
  
  attr_reader :n, :level, :width, :height, :app
  
  def initialize(template)
    @template = template
    @n = 32
  end
  
  def run!
    controller = self
    @level = Level.new @template
    @width, @height = level.width*n, level.height*n + n
    
    Shoes.app title: title, width: width, height: height do |app|
      controller.run app
    end
  end
  
  def run(app)
    @app = app
    @toolbar = LevelController::Toolbar.new self
    @board = LevelController::Board.new self
    
    render
  end
  
  protected
    def image_named(image_name)
      image image_path(image_name)
    end
    
    def image_path(image_name)
      File.expand_path File.dirname(__FILE__) + "/../images/#{image_name}"
    end
    
    def render
      @toolbar.render
      @board.render
      
      background_path = image_path 'background.png'
      dimensions = imagesize background_path
      offset = height - dimensions.last
      background background_path, width: dimensions.first, height: dimensions.last, top: offset
      on('level_solved') {alert 'Good job!'}
    end
    
    def title
      "Sokoban - Level #{level.number}"
    end
    
    def method_missing(method, *args, &block)
      app.send method, *args, &block
    end
end
