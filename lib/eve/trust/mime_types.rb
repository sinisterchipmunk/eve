if defined?(Mime) && defined?(Mime::Type)
  Mime::Type.register_alias "text/html", :eve
  Mime::Type.register_alias "text/html", :igb
end
