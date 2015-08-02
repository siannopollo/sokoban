module DependencyConcerns
  def concerned_with(*concerns)
    concerns.each do |concern|
      require "#{name.gsub('::', '/').gsub(/([A-Z])/) {"_#{$1.downcase}"}.sub(/^_/, '').gsub(/\/_/, '/')}/#{concern}"
    end
  end
end

Module.send :include, DependencyConcerns
