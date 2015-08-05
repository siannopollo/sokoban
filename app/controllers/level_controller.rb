class LevelController
  concerned_with :toolbar
  
  attr_reader :n, :level, :width, :height, :app
  
  def initialize(template)
    @template = template
    @n = 20
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
    @elements = {}
    @toolbar = LevelController::Toolbar.new self
    
    run_level
  end
  
  protected
    def character_for_object(object)
      character = ' '
      character = '#' if object.wall?
      character = '.' if object.target?
      character = 'o' if object.box?
      character = '@' if object.pawn?
      character
    end
    
    def run_level
      @toolbar.render
      
      render
      keypress do |direction|
        result = level.move direction
        if result.success?
          result.objects.each do |object|
            element = @elements[object]
            element.style top: object.y*n, left: object.x*n
            @toolbar.update_moves
          end
        end
      end
    end
    
    def render
      level.rows.each do |row|
        flow width: width/level.width.to_f do
          row.spaces.each do |space|
            render_object space
          end
          
          row.objects.each do |object|
            element = render_object object
            @elements[object] = element
          end
        end
      end
    end
    
    # Render either a space or an object
    def render_object(object)
      flow top: object.y*n+1, left: object.x*n, width: n, height: n do
        para character_for_object(object)
      end
    end
    
    def title
      "Sokoban - Level #{level.number}"
    end
    
    def method_missing(method, *args, &block)
      app.send method, *args, &block
    end
end
