module Eve
  class API
    module Connectivity
      MAX_JOURNAL_ENTRIES = 1000

      def walk(walk_id, options = {}, &block)
        options["before_#{walk_id}"] ||= 0
        array = yield options
        if array.size >= MAX_JOURNAL_ENTRIES
          begin
            min_id = nil
            array.each { |txn| min_id = txn.send(walk_id) if min_id.nil? || min_id > txn.send(walk_id) }
            array.concat walk(walk_id, options.merge("before_#{walk_id}" => min_id), &block)
          rescue Eve::Errors::UserInputErrors::InvalidBeforeTransID, Eve::Errors::UserInputErrors::InvalidBeforeRefID,
                 Eve::Errors::UserInputErrors::InvalidBeforeKillID
            # walking is internal, so we should catch the error internally too.
          end
        end
        array
      end

      def request(namespace, service_name, options = {})
        walk_id = options.delete(:walk_id) # we don't want these being sent to the server; it messes with the cache.
        walk_association = options.delete(:walk_association)
        if options.delete(:walk)
          raise ArgumentError, "Requires :walk_id" unless walk_id
          walk(walk_id.to_s, options) do |walk_options|
            Eve::API::Request.new(namespace, service_name, self.options.merge(walk_options)).dispatch.send(walk_association)
          end
        else
          Eve::API::Request.new(namespace, service_name, self.options.merge(options)).dispatch
        end
      end
    end
  end
end
