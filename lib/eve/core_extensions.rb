Dir[File.join(File.dirname(__FILE__), "core_extensions/**/*.rb")].each do |fi|
  require fi
end
