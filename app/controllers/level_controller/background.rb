class LevelController
  class Background < BaseController::Component
    def render
      background rgb(93,147,253)
      
      background_path = image_path 'background.png'
      dimensions = imagesize background_path
      offset = height - dimensions.last
      background background_path, width: dimensions.first, height: dimensions.last, top: offset
      
      clouds = rand(3) + 2
      clouds.to_i.times do
        spawn_cloud rand(width)
      end
      
      animate!
    end
    
    protected
      def animate!
        animate 30 do |frame|
          @elements.each do |element, fps|
            if (frame % fps) == 0
              if element.left <= element.width * -1
                element.style top: cloud_top, left: width
              else
                element.style left: element.left - 1
              end
            end
          end
        end
      end
      
      # ensure clouds stay out of toolbar, or bottom of screen
      def cloud_top
        min, max = n, height - 2*n
        top = max
        top = rand(height - 2*n) + n until top < max
        top
      end
      
      def reset
        @elements = {}
      end
      
      def spawn_cloud(left = width)
        number = [1,2,3].sample
        image_name = "cloud-#{number}.png"
        path = image_path image_name
        cloud_width = {1 => 32, 2 => 48, 3 => 64}[number]
        
        element = flow(top: cloud_top, left: left, width: cloud_width, height: 32) do
          background path
        end
        @elements[element] = rand(4).to_i + 1
      end
  end
end
