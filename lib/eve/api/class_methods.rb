module Eve
  class API
    module ClassMethods
      def server_status
        Eve::API.new.server_status
      end
    end
  end
end
