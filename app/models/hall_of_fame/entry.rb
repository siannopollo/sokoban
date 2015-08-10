class HallOfFame
  class Entry
    concerned_with :collection
    
    def initialize(data)
      @data = data
    end
    
    %w(name time moves).each do |m|
      define_method m do
        @data[m.to_sym]
      end
    end
    
    def <=>(other)
      comparison_value <=> other.comparison_value
    end
    
    protected
      def comparison_value
        time + moves
      end
  end
end
