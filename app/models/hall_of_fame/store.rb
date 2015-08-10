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
      @data[level_number] << entry_data
      write_data
    end
    
    def fetch(level_number)
      @data[level_number]
    end
    
    protected
      def write_data
        File.open(@filename, File::CREAT|File::TRUNC|File::WRONLY) do |file|
          file.puts Marshal.dump(@data)
        end
      end
  end
end
