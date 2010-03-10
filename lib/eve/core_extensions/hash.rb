class Hash
  def without(*keys)
    ret = self.dup
    keys.flatten.each { |key| ret.delete key }
    ret
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
  def rename(buf)
    buf.each { |old_key, new_key| self[new_key] = delete(old_key) if keys.include?(old_key) }
    self
  end
end
