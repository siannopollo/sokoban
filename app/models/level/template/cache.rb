class Level
  class Template
    class << self
      def all
        @all_templates ||= {}
      end
      
      def add_template(template)
        all[counter] = template
        counter
      ensure
        @counter += 1
      end
      
      def counter
        @counter ||= 1
      end
      
      def reset_cache
        @all_templates = {}
        @counter = 1
      end
    end
  end
end
