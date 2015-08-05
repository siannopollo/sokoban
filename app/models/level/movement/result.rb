class Level
  protected
    def blocked!
      result! :blocked
    end
    
    def invalid!
      result! :invalid
    end
    
    def result!(*args)
      Level::Movement::Result.new *args
    end
  
  module Movement
    class Result
      def initialize(type, object = nil, additional_result = nil)
        @type = type
        @object = object
        @additional_result = additional_result
      end
      
      %w(blocked success invalid).each do |t|
        define_method "#{t}?" do
          @type == t.to_sym
        end
      end
      
      def objects
        [@object].tap do |o|
          o.concat @additional_result.objects if @additional_result
        end.compact
      end
    end
  end
end
