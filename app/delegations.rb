module Delegations
  def delegate(*args)
    options = args.pop
    delegator = options[:to]
    args.each do |method|
      define_method method do |*arguments, &block|
        send(delegator).send method, *arguments, &block
      end
    end
  end
end

Module.send :include, Delegations
