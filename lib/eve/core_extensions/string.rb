class String
  # The inverse of +ActiveSupport::Inflection#humanize+: Lowercases the first letter, and turns spaces into underscores.
  # This is meant to assist in creating method names. A camelCase method name can be created using #dehumanize:
  #   "say_hello_to_the_world".camelize.dehumanize  # => "sayHelloToTheWorld"
  #
  # This can also be used for creating permalinks:
  #   "Say hello to the world".dehumanize           # => "say_hello_to_the_world"
  def dehumanize
    self.camelize.gsub(/^([A-Z])/) { |x| x.downcase }.gsub(/ /, '_')
  end
end
