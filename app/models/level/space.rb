class Level
  class Space
    concerned_with :base, :empty, :target, :wall
    
    def self.create(string_representation, x, y)
      class_name = {
        ' ' => 'Empty',
        'o' => 'Empty',
        '@' => 'Empty',
        '.' => 'Target',
        '#' => 'Wall'
      }[string_representation]
      Level::Space.const_get(class_name).new x, y
    end
  end
end
