module Eve
  module Trust
    class IgbInterface
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def trusted?
        request.headers['HTTP_EVE_TRUSTED'] == 'yes'
      end

      def igb?
        request.user_agent && request.user_agent[/eve\-minibrowser/i]
      end
    end
  end
end
