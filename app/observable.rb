module Observable
  def on(event_name, &block)
    event_handlers[event_name] << block
  end
  
  def trigger(event_name, *args)
    event_handlers[event_name].each do |handler|
      handler.call *args
    end
  end
  
  def event_handlers
    @event_handlers ||= Hash.new {|h,k| h[k] = []}
  end
end
