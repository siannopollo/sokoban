class Level
  class Object
    class Base
      attr_reader :x, :y
      
      def initialize(x, y)
        @x, @y = x, y
      end
      
      def box?() false end
      def pawn?() false end
    end
  end
end
