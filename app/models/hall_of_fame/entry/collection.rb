class HallOfFame
  def entries(level_number)
    HallOfFame::Entry::Collection.new level_number
  end
  
  class Entry
    class Collection
      include Enumerable
      
      def initialize(level_number)
        @level_number = level_number
      end
      
      def add_entry(data = {})
        store.add @level_number, data
      end
      
      def each
        all_entries.each {|e| yield e}
      end
      
      alias_method :size, :count
      
      protected
        def all_entries
          @all_entries ||= begin
            data = store.fetch @level_number
            if data
              data.map {|d| HallOfFame::Entry.new d}.sort
            else
              []
            end
          end
        end
        
        def store
          HallOfFame.instance.store
        end
    end
  end
end
