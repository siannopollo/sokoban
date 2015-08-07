$:.unshift File.expand_path('.')
require 'app/concerns'
require 'app/delegations'
require 'app/observable'

%w(models controllers).each do |dir|
  Dir.glob("app/#{dir}/*.rb").each do |f|
    $:.unshift File.dirname(f)
    require File.expand_path(f)
  end
end
