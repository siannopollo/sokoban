class LevelController
  class Toolbar
    attr_reader :controller
    
    def initialize(controller)
      @controller = controller
    end
    
    def render
      flow width: width, height: n do
        background black
        @moves = para 'moves: 0', text_options.merge(width: 100, background: red)
        
        @timer = para '0:00', text_options.merge(left: 100, width: 50)
      end
    end
    
    def update_moves
      @moves.replace "moves: #{level.moves}"
      start_timer
    end
    
    protected
      def text_options
        {font: (n/2.0).to_s, top: -1*(n/10.0), stroke: white}
      end
      
      def start_timer
        return if @timer_started
        
        @time = 0
        every(1) do
          @time += 1
          seconds = @time % 60
          minutes = (@time / 60) % 60
          @timer.replace "#{minutes}:#{seconds.to_s.rjust 2, '0'}"
        end
        
        @timer_started = true
      end
      
      def method_missing(method, *args, &block)
        controller.send method, *args, &block
      end
  end
end
