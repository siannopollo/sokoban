module BaseController
  concerned_with :component
  
  def self.included(controller)
    controller.class_eval do
      include Observable
      attr_reader :app
    end
  end
  
  def image_named(image_name)
    image image_path(image_name)
  end
  
  def image_path(image_name)
    File.expand_path File.dirname(__FILE__) + "/../images/#{image_name}"
  end
  
  def n
    32
  end
  
  def method_missing(method, *args, &block)
    app.send method, *args, &block
  end
end
