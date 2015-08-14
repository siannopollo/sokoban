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
    end
    
    def spawn_cloud(left = width)
      number = [1,2,3].sample
      image_name = "cloud-#{number}.png"
      path = image_path image_name
      width = {1 => 32, 2 => 48, 3 => 64}[number]
      
      element = flow(top: cloud_top, left: left, width: width, height: 32) do
        background path
      end
      
      animate(rand(24).to_i) {
        if element.left <= element.width * -1
          element.style top: cloud_top, left: width
        else
          element.style left: element.left - 1
        end
      }
    end
    
    protected
      # ensure clouds stay out of toolbar, or bottom of screen
      def cloud_top
        min, max = n, height - 2*n
        top = max
        top = rand(height - 2*n) + n until top < max
        top
      end
  end
end
