require 'singleton'

class MainWindowController
  include Singleton
  include BaseController
  
  concerned_with :background, :templates
  
  attr_reader :height, :width
  
  def run!
    @height, @width = 400, 480
    
    controller = self
    Level::Template.load_all
    
    Shoes.app title: 'Sokoban', width: @width, height: @height do |app|
      controller.run app
    end
  end
  
  def run(app)
    @app = app
    @background = MainWindowController::Background.new self
    @templates = MainWindowController::Templates.new self
    
    render
  end
  
  protected
    def render
      @background.render
      @templates.render
    end
end
