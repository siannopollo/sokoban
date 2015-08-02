class Level
  class Parser
    def parse(string_template)
      lines = string_template.split("\n").reject(&:empty?)
      
      minimum_leading_excess_whitespace = lines.map do |line|
        match = line.match(/^\s+/)
        match ? match[0].size : 0
      end.sort.first
      
      lines.map! {|l| l.sub /^\s{#{minimum_leading_excess_whitespace}}/, ''}
      
      Level::Template.new lines.reject(&:empty?)
    end
    
    def parse_all
      templates = File.read('app/models/level/levels.txt').chomp
      templates.split("\n\n").each {|data| parse data}
    end
  end
end
