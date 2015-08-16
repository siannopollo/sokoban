class Level
  class Row
    attr_reader :y, :spaces, :objects
    
    def initialize(string_representation, y)
      @string_representation = string_representation
      @y = y
      
      @characters = string_representation.split ''
      
      @spaces = @characters.each_with_index.map {|c,x| Level::Space.create c, x, y}
      @objects = @characters.each_with_index.map {|c,x| Level::Object.create c, x, y}.compact
    end
    
    {wall: :walls, empty: :empties, target: :targets}.each do |type, plural|
      define_method plural do
        result = instance_variable_get "@#{plural}"
        return result if result
        instance_variable_set "@#{plural}", @spaces.select(&"#{type}?".to_sym)
      end
    end
    
    def boxes
      @objects.select(&:box?)
    end
    
    def pawn
      return nil unless @string_representation =~ /@|\+/
      @pawn ||= @objects.detect(&:pawn?)
    end
    
    def to_s
      @string_representation
    end
    
    def inspect
      %{#<Level::Row y="#{y}" visual="#{to_s}">}
    end
  end
end
