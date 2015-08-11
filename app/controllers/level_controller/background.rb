class LevelController
  class Background < LevelController::Component
    def render
      background rgb(93,147,253)
      
      background_path = image_path 'background.png'
      dimensions = imagesize background_path
      offset = height - dimensions.last
      background background_path, width: dimensions.first, height: dimensions.last, top: offset
      
      clouds = rand(6) + 2
      clouds.to_i.times do
        spawn_cloud rand(width)
      end
    end
    
    def spawn_cloud(left = width)
      image_name = "cloud-#{[1,2,3].sample}.png"
      background_path = image_path image_name
      dimensions = imagesize background_path
      
      element = flow(top: cloud_top, left: left, width: dimensions.first, height: dimensions.last) do
        style background: image_named(image_name)
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
