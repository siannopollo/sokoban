module Delegations
  def delegate(*args)
    options = args.pop
    delegator = options[:to]
    args.each do |method|
      define_method method do
        send(delegator).send method
      end
    end
  end
end

Module.send :include, Delegations
