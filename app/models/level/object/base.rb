class Level
  class Object
    class Base
      include Level::Coordinated
      
      def box?() false end
      def empty?() false end
      def pawn?() false end
      def target?() false end
      def wall?() false end
    end
  end
end
