require 'fileutils'

RSpec.configure do |config|
  config.before do
    filename = File.expand_path(File.dirname(__FILE__) + '/.test-hall-of-fame')
    HallOfFame.instance.store_filename = filename
  end
  
  config.after do
    FileUtils.rm_f HallOfFame.instance.store_filename
    HallOfFame.instance.instance_variable_set '@store', nil
  end
end
