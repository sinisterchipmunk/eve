module Eve
  class API
    module Services
      module Misc
        def character_portrait(character_id, options = { :size => 64 })
          options[:s] ||= options.delete(:size)
          options[:c] ||= character_id
          request('', 'serv', options.reverse_merge(:base_uri => 'http://img.eve.is',
                                                    :extension => 'asp',
                                                    :camelize => false,
                                                    :response_type => :string))
        end
      end
    end
  end
end
