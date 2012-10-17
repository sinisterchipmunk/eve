class Eve::API::Response::Rowset < Array
  attr_reader :columns, :key, :name

  def initialize(rowset)
    super()

    @columns = rowset.attributes['columns'].value.split(/\s*,\s*/)
    @name = rowset.attributes['name'].value

    if rowset.attributes.key?('key')
      @key  = rowset.attributes['key'].value
    end

    rowset.children.each do |child|
      self << Eve::API::Response::Row.new(child, @columns) unless child.text?
    end
  end
end
