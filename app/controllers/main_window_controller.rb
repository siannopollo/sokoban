require 'singleton'

class MainWindowController
  include Singleton
  
  def run
    Level::Template.load_all
    
    Shoes.app do
      Level::Template.all.each do |number, template|
        button(number.to_s) {
          LevelController.new(template).run!
        }
      end
    end
  end
end
