class HallOfFame
  class Entry
    concerned_with :collection
    
    def initialize(level_number, data)
      @level_number = level_number
      @data = data
    end
    
    %w(name time moves id).each do |m|
      define_method m do
        @data[m.to_sym]
      end
      
      define_method "#{m}=" do |value|
        @data[m.to_sym] = value
        HallOfFame.instance.store.synchronize @level_number, @data
      end
    end
    
    def <=>(other)
      comparison_data <=> other.comparison_data
    end
    
    def ==(other)
      comparison_data == other.comparison_data
    end
    
    protected
      def comparison_data
        [@level_number, comparison_value, name.to_s, id]
      end
      
      def comparison_value
        time + moves
      end
  end
end
