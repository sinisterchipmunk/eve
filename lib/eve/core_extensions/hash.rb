class Hash
  def without(*keys)
    keys.flatten!
    inject({}) do |hash, (key, value)|
      hash[key] = value unless keys.include?(key)
      hash
    end
  end

  def without_values(*values)
    values.flatten!
    inject({}) do |hash, (key, value)|
      hash[key] = value unless values.include?(value)
      hash
    end
  end

  # Returns a hash that is a copy of this one, except that all nil values have been removed, making them
  # essentially "optional" keys.
  def optionalize
    without_values(nil)
  end

  alias without_nil_values optionalize

  def camelize_keys
    stringify_keys.rename(inject({}) do |renamed, (key, value)|
      renamed[key.to_s] = key.to_s.camelize
      renamed
    end)
  end

  # Takes a hash whose keys must match keys in this hash. Those keys will be renamed to match the
  # corresponding value in the specified hash.
  #
  # Keys not found are ignored.
  #
  # Returns self.
  #
  # Example:
  #   { :a => 1 }.rename(:a => :b)
  #     => {:b => 1}
  #
  def rename(to)
    merge!(inject({}) do |hash, (old_key, value)|
      hash[to[old_key] || old_key] = value
      delete(old_key)
      hash
    end)
  end
end
