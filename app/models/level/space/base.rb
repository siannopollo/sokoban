class Level
  class Space
    class Base
      attr_reader :x, :y
      
      def initialize(x, y)
        @x, @y = x, y
      end
      
      def empty?() false end
      def target?() false end
      def wall?() false end
    end
  end
end
