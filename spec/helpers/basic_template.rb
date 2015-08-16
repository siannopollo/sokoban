module BasicTemplate
  def basic_template
    representation = %{
      ###
      #.#
      # ####
    ###o o.#
    #. o@###
    ####o#
       #.#
       ###
    }
    Level::Template.parse representation
  end
end

RSpec.configure do |config|
  config.include BasicTemplate
  config.after do
    Level::Template.reset_cache
  end
end
