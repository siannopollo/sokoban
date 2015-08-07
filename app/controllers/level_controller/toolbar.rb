class LevelController
  class Toolbar < LevelController::Component
    def render
      flow width: width, height: n do
        background rgb(93,147,253)
        
        flow width: 0.25, height: 0.5 do
          para 'MARIO', text_options.merge(left: n)
        end
        flow width: 0.25, height: 0.5 # blank for where coins would be
        flow width: 0.25, height: 0.5 do
          para 'WORLD', text_options.merge(align: 'center')
        end
        flow width: 0.20, height: 0.5 do
          para 'TIME', text_options.merge(right: n, align: 'right')
        end
        
        flow width: 0.25, height: 0.5 do
          @moves = para '00000', text_options.merge(left: n, top: -3)
        end
        flow width: 0.25, height: 0.5 # blank for where coins would be
        flow width: 0.25, height: 0.5 do
          world, number = level.number.divmod 10
          para [world+1, number].join('-'), text_options.merge(align: 'center', top: -3)
        end
        flow width: 0.20, height: 0.5 do
          @timer = para '0', text_options.merge(right: n, align: 'right', top: -3)
        end
      end
    end
    
    def update_moves
      @moves.replace level.moves.to_s.rjust(5, '0')
      start_timer
    end
    
    protected
      def reset
        on('move:successful') {update_moves}
        on('level:solved') {update_moves}
      end
      
      def start_timer
        return if @timer_started
        
        @time = 0
        every(1) do
          @time += 1
          @timer.replace @time.to_s
        end
        
        @timer_started = true
      end
      
      def text_options
        {font: "Monaco #{n/4}", stroke: white}
      end
  end
end
