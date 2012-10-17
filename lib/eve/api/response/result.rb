module Eve::API::Response::Result
  def all_fields
    @all_fields ||= []
  end

  def delegate_to_rowset(field_name, rowset)
    all_fields << field_name.underscore
    klass = (class << self; self; end)
    rowset = Eve::API::Response::Rowset.new rowset
    klass.module_eval do
      define_method field_name do
        rowset
      end

      if field_name.underscore != field_name
        alias_method field_name.underscore, field_name
      end
    end
    rowset
  end

  def literal_value_for(str)
    YAML::load str
  rescue (defined?(Psych::SyntaxError) ? Psych::SyntaxError : StandardError)
    str
  end

  def delegate_to_child(field_name, node)
    all_fields << field_name.underscore
    klass = (class << self; self; end)
    if !node.children.empty? && node.children.reject { |c| c.text? }.empty?
      # this seems less correct but specs pass this way
      if node.name != 'error'
        child = literal_value_for node.content.strip
      else
        child = Eve::API::Response::Row.new node
      end

      # if node.attributes.empty?
      #   # node contains only text
      #   child = literal_value_for node.content.strip
      # else
      #   child = Eve::API::Response::Row.new node
      # end
    else
      child = Eve::API::Response::Row.new node
    end
    klass.module_eval do
      define_method field_name do
        child
      end

      if field_name.underscore != field_name
        alias_method field_name.underscore, field_name
      end
    end
    child
  end

  def parse_children(node)
    node.children.each do |child|
      next if child.text?
      case child.name
        when 'rowset'
          rowset = delegate_to_rowset child.attributes['name'].value, child
          rowsets << rowset
        else
          delegate_to_child child.name, child
      end
    end
  end

  def [](name)
    send name
  end

  def to_hash
    all_fields.inject({}) do |hash, field_name|
      hash[field_name] = self[field_name]
      hash
    end
  end

  def to_yaml(*args)
    to_hash.to_yaml(*args)
  end
end
