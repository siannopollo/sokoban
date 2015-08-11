class HallOfFame
  attr_writer :store_filename
  
  def store
    @store ||= HallOfFame::Store.new
  end
  
  def store_filename
    @store_filename || File.expand_path(File.dirname(__FILE__) + '/../../../.hall-of-fame')
  end
  
  class Store
    def initialize
      @filename = HallOfFame.instance.store_filename
      @data = if File.exists?(@filename)
        Marshal.load File.read(@filename)
      else
        {}
      end
    end
    
    def add(level_number, entry_data)
      @data[level_number] ||= []
      entry_data[:id] = entry_data.object_id
      @data[level_number] << entry_data
      write_data
    end
    
    def fetch(level_number)
      @data[level_number]
    end
    
    def synchronize(level_number, entry_data)
      level_data = @data[level_number]
      existing_data = level_data.detect {|d| d[:id] == entry_data[:id]}
      existing_data.update entry_data
      write_data
    end
    
    protected
      def write_data
        File.open(@filename, File::CREAT|File::TRUNC|File::WRONLY) do |file|
          file.puts Marshal.dump(@data)
        end
      end
  end
end
