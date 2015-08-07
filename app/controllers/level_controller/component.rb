class LevelController
  class Component < Struct.new(:controller)
    attr_reader :controller
    
    def initialize(controller)
      @controller = controller
      reset
    end
    
    protected
      def method_missing(method, *args, &block)
        controller.send method, *args, &block
      end
      
      def reset
      end
  end
end
