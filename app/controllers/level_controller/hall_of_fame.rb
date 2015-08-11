class LevelController
  class HallOfFame < LevelController::Component
    
    protected
      def render
        flow top: n, left: n, height: @dimensions[:height], width: @dimensions[:width] do
          background rgb(0,0,0,0.75)
          
          stack do
            render_title
            render_headers
            # Need to add the entry first, then render out each row and allow the user to
            # change their initials, arcade-style:
            # up/down to change letters, arrows to switch, enter to save
            # Should color the newly created row differently
            15.times do |i|
              render_entry i
            end
          end
        end
      end
      
      def render_entry(n)
        text_options = {font: 'Stencil 12', stroke: white, align: 'center'}
        flow with: @dimensions[:width] do
          flow(width: 0.25) {para "#{n+1}", text_options}
          flow(width: 0.25) {para 'AAA', text_options}
          flow(width: 0.25) {para '240', text_options}
          flow(width: 0.25) {para '64', text_options}
        end
      end
      
      def render_headers
        text_options = {font: 'Stencil 16', stroke: white, align: 'center'}
        flow with: @dimensions[:width] do
          flow(width: 0.25) {para 'RANK', text_options}
          flow(width: 0.25) {para 'NAME', text_options}
          flow(width: 0.25) {para 'MOVES', text_options}
          flow(width: 0.25) {para 'TIME', text_options}
        end
      end
      
      def render_title
        title = para 'HALL OF FAME', font: 'Stencil 30', align: 'center', stroke: white
        stroke white
        info title.height.inspect
        line 5, 40, @dimensions[:width] - 10, 41
      end
      
      def reset
        @dimensions = {width: (level.width - 2)*n, height: (level.height - 1)*n}
        on('level:solved') {render}
      end
  end
end
