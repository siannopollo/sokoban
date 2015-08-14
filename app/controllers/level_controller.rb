class LevelController
  include BaseController
  
  concerned_with :board, :toolbar, :background, :hall_of_fame
  
  attr_reader :level, :width, :height
  attr_writer :level_solved
  
  def initialize(template)
    @template = template
  end
  
  def level_solved?
    !!@level_solved
  end
  
  def run!
    controller = self
    @level = Level.new @template
    @width, @height = level.width*n, level.height*n + n
    
    Shoes.app title: title, width: width, height: height, resizable: false do |app|
      controller.run app
    end
  end
  
  def run(app)
    on('level:solved') {self.level_solved = true}
    
    @app = app
    @toolbar = LevelController::Toolbar.new self
    @board = LevelController::Board.new self
    @background = LevelController::Background.new self
    @hall_of_fame = LevelController::HallOfFame.new self
    
    render
  end
  
  protected
    def render
      @background.render
      @toolbar.render
      @board.render
    end
    
    def title
      "Sokoban - Level #{level.number}"
    end
end
