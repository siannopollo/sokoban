class Level
  class Template
    concerned_with :parse, :cache
    
    attr_reader :rows, :width, :height, :number
    
    def initialize(_rows)
      @width = _rows.map(&:size).sort.last
      @height = _rows.size
      
      # Pad out each row to take up the entire width
      _rows.map! {|r| r.ljust width, ' '}
      
      @rows = _rows.each_with_index.map {|r, y| Level::Row.new r, y}
      @number = self.class.add_template self
    end
    
    # Creates a deep copy of the rows
    def rows_for_level
      Marshal.load Marshal.dump(rows)
    end
    
    def to_s
      @to_s ||= @rows.map(&:to_s).join "\n"
    end
    
    def inspect
      %{#<Level::Template number="#{@number}" \n#{to_s}\n>}
    end
  end
end
