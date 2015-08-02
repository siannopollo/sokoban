class Level
  class Template
    attr_reader :rows, :width, :height
    
    def initialize(_rows)
      @width = _rows.map(&:size).sort.last
      @height = _rows.size
      
      # Pad out each row to take up the entire width
      _rows.map! {|r| r.ljust width, ' '}
      
      @rows = [].tap do |all_rows|
        _rows.each_with_index do |r, y|
          all_rows << Level::Row.new(r, y)
        end
      end
    end
  end
end
