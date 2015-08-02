class Level
  concerned_with :parser, :template, :row, :object, :space
  
  attr_reader :rows, :template
  
  delegate :height, :width, to: :template
  
  def initialize(template)
    @template = template
    @rows = template.rows.dup
  end
end
