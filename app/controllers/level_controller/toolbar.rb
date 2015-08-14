class LevelController
  attr_accessor :time
  
  class Toolbar < BaseController::Component
    def render
      top = n / 2.8
      flow width: width, height: n do
        flow width: 0.25 do
          stack do
            para 'MARIO', text_options.merge(left: n)
            @moves = para '00000', text_options.merge(left: n, top: top)
          end
        end
        
        flow width: 0.25 do
          flow do
            style background: image_named('reset.png'), top: 5
            click {reset_level}
          end
        end
        
        flow width: 0.25 do
          stack do
            para 'WORLD', text_options.merge(align: 'center')
            para level.world, text_options.merge(align: 'center', top: top)
          end
        end
        flow width: 0.20 do
          stack do
            para 'TIME', text_options.merge(align: 'right')
            @timer = para '0', text_options.merge(align: 'right', top: top)
          end
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
        on('level:solved') {stop_metrics}
        on('level:reset') {reset!}
      end
      
      def reset!
        update_moves
        
        @timer.replace '0'
        @time_interval.stop
        @timer_started = nil
      end
      
      def reset_level
        return if level_solved?
        
        level.reset
        trigger 'level:reset'
      end
      
      def start_timer
        return if @timer_started
        
        @time = 0
        @time_interval = every(1) do
          @time += 1
          @timer.replace @time.to_s
        end
        
        @timer_started = true
      end
      
      def stop_metrics
        @time_interval.stop
        controller.time = @time
      end
      
      def text_options
        {font: "Monaco #{n/4}", stroke: white}
      end
  end
end
