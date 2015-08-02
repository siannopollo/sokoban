class Level
  class Space
    class Base
      include Level::Coordinated
      
      def empty?() false end
      def target?() false end
      def wall?() false end
      
      def move(direction)
        raise "Spaces can't be moved"
      end
    end
  end
end
