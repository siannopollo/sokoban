class Level
  class Object
    concerned_with :base, :box, :pawn
    
    def self.create(string_representation, x, y)
      class_name = {
        'o' => 'Box',
        '*' => 'Box',
        '@' => 'Pawn',
        '+' => 'Pawn'
      }[string_representation]
      return nil unless class_name
      
      Level::Object.const_get(class_name).new x, y
    end
  end
end
