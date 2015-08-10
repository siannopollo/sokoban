require 'singleton'

class HallOfFame
  include Singleton
  
  concerned_with :entry, :store
end
