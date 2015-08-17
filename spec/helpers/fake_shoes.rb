class Shoes
  include Singleton
  
  def self.app(options, &block)
    block.call instance
  end
  
  def initialize
    @buttons = {}
    @keypresses = []
    @clicks = []
  end
  
  %w(
    rgb background flow stack para image style replace clear
    timer every remove start stop stroke line white green red
  ).each do |m|
    define_method m do |*args, &block|
      block.call if block
      self
    end
  end
  
  def animate(fps, &block)
    # don't do anything for animations
    self
  end
  
  def button(button_name, options = {}, &block)
    @buttons[button_name] = block
  end
  
  def click_button(button_name)
    handler = @buttons[button_name]
    raise "No handler registered for button #{button_name.inspect}" if handler.nil?
    handler.call
  end
  
  # Very naive, since we're not scoping clicks to any particular place
  # Without building out this mock class more fully, this will have to do
  def click(&block)
    @clicks << block
  end
  
  def imagesize(*args)
    [32,32]
  end
  
  def keypress(&block)
    @keypresses << block
  end
  
  def perform_click
    @clicks.each {|h| h.call}
  end
  
  def press_key(key)
    @keypresses.each {|h| h.call key}
  end
  
  module SpecHelpers
    def click_button(button_name)
      Shoes.instance.click_button button_name
    end
    
    def perform_click
      Shoes.instance.perform_click
    end
    
    def press_key(key)
      Shoes.instance.press_key key
    end
  end
end
