class Level
  class Space
    class Wall < Level::Space::Base
      def wall?() true end
    end
  end
end
