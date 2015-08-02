class Level
  class Parser
    def parse(string_template)
      lines = string_template.split("\n").reject(&:empty?)
      
      minimum_leading_excess_whitespace = lines.map do |line|
        match = line.match(/^\s+/)
        match ? match[0].size : 0
      end.sort.first
      
      lines.map! {|l| l.sub /^\s{#{minimum_leading_excess_whitespace}}/, ''}
      
      template = Level::Template.new lines.reject(&:empty?)
      Level.new template
    end
  end
end
