module Eve
  module Version
    MAJOR, MINOR, PATCH = 2, 0, 1
    STRING = [MAJOR, MINOR, PATCH].join('.')
  end
  
  VERSION = Version::STRING
end
