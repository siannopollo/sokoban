class LevelController
  attr_reader :level, :width, :height, :app
  
  delegate :stack, :flow, :para, :keypress, :alert, :debug, to: :app
  
  def initialize(template)
    @template = template
  end
  
  def run!
    controller = self
    @level = Level.new @template
    @width, @height = level.width*20, level.height*20
    
    Shoes.app title: title, width: width, height: height do |app|
      controller.run app
    end
  end
  
  def run(app)
    @app = app
    @elements = {}
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
      render
      keypress do |direction|
        result = level.move direction
        if result.moved?
          result.objects.each do |object|
            element = @elements[object]
            element.style top: object.y*20, left: object.x*20
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
      flow top: object.y*20, left: object.x*20, width: 20, height: 20 do
        para character_for_object(object)
      end
    end
    
    def title
      "Sokoban - Level #{level.number}"
    end
end
