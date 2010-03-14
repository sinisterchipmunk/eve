module Eve
  class API
    module Services
      module Misc
        # Returns a binary String representing a JPEG image that is the portrait of the character with
        # the specified ID.
        #
        # Optionally, the :size may be set to 64x64 or 256x256. This defaults to 64x64.
        #
        # Example:
        #  api.character_portrait(661196469)
        #
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
