class Level
  module Coordinated
    def self.included(base)
      base.class_eval do
        attr_reader :x, :y
        
        def initialize(x, y)
          @x, @y = x, y
        end
        
        def coordinates
          [x, y]
        end
        
        def move(direction)
          additions = additions_for_direction direction
          @x += additions.first
          @y += additions.last
        end
        
        def simulate_move(direction)
          _x, _y = x, y
          additions = additions_for_direction direction
          [_x + additions.first, _y + additions.last]
        end
        
        protected
          def additions_for_direction(direction)
            {
              up: [0,-1], down: [0,1], left: [-1,0], right: [1,0]
            }[direction]
          end
      end
    end
  end
end
