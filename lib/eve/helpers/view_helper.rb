module Eve
  module Helpers
    # Provides various IGB-specific helper methods.
    module ViewHelper
      def self.included(base)
        base.instance_eval do
          delegate :igb, :to => :controller
          delegate :igb?, :to => :igb
        end
      end
    end
  end
end
