class Level
  class Object
    class Base
      include Level::Coordinated
      
      def box?() false end
      def pawn?() false end
    end
  end
end
