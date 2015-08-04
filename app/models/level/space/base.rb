class Level
  class Space
    class Base < Level::Object::Base
      def move(direction)
        raise "Spaces can't be moved"
      end
    end
  end
end
