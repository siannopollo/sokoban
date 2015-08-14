class MainWindowController
  class Templates < BaseController::Component
    def render
      flow margin: 40 do
        Level::Template.all.each do |number, template|
          button(template.world, width: 50, height: 28) {
            LevelController.new(template).run!
          }
        end
      end
    end
  end
end
