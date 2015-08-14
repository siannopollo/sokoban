class LevelController
  class HallOfFame < BaseController::Component
    protected
      def blink_cursor
        @blink_timer = animate(3) do |n|
          if @entry_saved
            @blink_timer.stop
          else
            @name_field.replace name_field_value.sub('-', n.even? ? ' ' : '-')
          end
        end
      end
      
      def collection
        ::HallOfFame.instance.entries level.number
      end
      
      def render
        @entry = collection.add_entry time: controller.time, moves: level.moves
        
        flow top: n, left: n, height: @dimensions[:height], width: @dimensions[:width] do
          background rgb(0,0,0,0.75)
          
          stack do
            render_title
            render_headers
            collection.entries.each_with_index do |entry, i|
              render_entry entry, i
            end
          end
        end
      end
      
      def render_entry(entry, i)
        text_options = {font: 'Andale Mono 14', stroke: white, align: 'center'}
        text_options[:stroke] = green if entry == @entry
        flow with: @dimensions[:width], height: n do
          flow(width: 0.2) {para "#{i+1}", text_options}
          flow(width: 0.4) do
            if entry == @entry
              @name_field = para '-'*10, text_options.merge(stroke: red, rise: 0)
              keypress() {|k| update_name k}
              blink_cursor
            else
              para entry.name, text_options
            end
          end
          flow(width: 0.2) {para entry.moves, text_options}
          flow(width: 0.2) {para entry.time, text_options}
        end
      end
      
      def render_headers
        text_options = {font: 'Stencil 16', stroke: white, align: 'center'}
        flow with: @dimensions[:width] do
          flow(width: 0.2) {para 'RANK', text_options}
          flow(width: 0.4) {para 'NAME', text_options}
          flow(width: 0.2) {para 'MOVES', text_options}
          flow(width: 0.2) {para 'TIME', text_options}
        end
      end
      
      def render_title
        title = para 'HALL OF FAME', font: 'Stencil 30', align: 'center', stroke: white
        stroke white
        line 5, 40, @dimensions[:width] - 10, 41
      end
      
      def reset
        @entry = nil
        @name = ''
        @dimensions = {width: (level.width - 2)*n, height: (level.height - 1)*n}
        on('level:solved') {render}
      end
      
      def save_entry
        @entry.name = @name
        @name_field.replace @name
        @name_field.style kerning: 0, stroke: green
        @entry_saved = true
      end
      
      def update_name(k)
        return if @entry_saved
        
        case k
        when :backspace then @name.chop!
        when "\n"
          return save_entry
        when String
          @name << k
        end
        
        @name = @name.slice 0, 10
        @name_field.replace name_field_value
      end
      
      def name_field_value
        @name.ljust 10, '-'
      end
  end
end
