module Eve
  class API
    module Connectivity
      MAX_JOURNAL_ENTRIES = 1000

      def walk(walk_id, walk_association, options = {}, &block)
        raise ArgumentError, "Requires :walk_id" if walk_id.blank?
        raise ArgumentError, "Requires :walk_association" if walk_association.blank?
        options[walk_id] ||= 0
        return_value = yield options
        array = return_value.send(walk_association)
        if array.size >= MAX_JOURNAL_ENTRIES
          begin
            min_id = nil
            primary_key = array.primary_key
            array.each { |txn| min_id = txn.send(primary_key) if min_id.nil? || min_id > txn.send(primary_key) }
            array.concat walk(walk_id, options.merge(walk_id => min_id), &block).send(walk_association)
          rescue Eve::Errors::UserInputErrors::InvalidBeforeTransID, Eve::Errors::UserInputErrors::InvalidBeforeRefID,
                 Eve::Errors::UserInputErrors::InvalidBeforeKillID
            # walking is internal, so we should catch the error internally too.
          end
        end
        return_value
      end

      def request(namespace, service_name, options = {})
        walk_id = options.delete(:walk_id) # we don't want these being sent to the server; it messes with the cache.
        walk_association = options.delete(:walk_association)
        if options.delete(:walk)
          walk(walk_id.to_s, walk_association, options) do |walk_options|
            Eve::API::Request.new(namespace, service_name, self.options.merge(walk_options)).dispatch
          end
        else
          Eve::API::Request.new(namespace, service_name, self.options.merge(options)).dispatch
        end
      end
    end
  end
end
