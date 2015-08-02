class Level
  class Template
    class << self
      def parse(string_template)
        lines = string_template.split("\n").reject(&:empty?)
        
        minimum_leading_excess_whitespace = lines.map do |line|
          match = line.match(/^\s+/)
          match ? match[0].size : 0
        end.sort.first
        
        # Remove any excess leading whitespace that is not part of the grid
        lines.map! {|l| l.sub /^\s{#{minimum_leading_excess_whitespace}}/, ''}
        
        new lines.reject(&:empty?)
      end
      
      def parse_all
        templates = File.read('app/models/level/levels.txt').chomp
        templates.split("\n\n").each {|data| parse data}
      end
    end
  end
end
