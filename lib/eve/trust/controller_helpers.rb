module Eve
  module Trust
    module ControllerHelpers
      def self.included(base)
        base.instance_eval do
          hide_action :trust_message, :trust_message=, :detect_igb, :template_exists?,
                      :set_igb_or_default, :default_template_exists?, :mock_methods_for_testing!,
                      :igb, :igb?, :set_igb, :require_trust, :prefer_trust, :deliver_trust_message
          class_inheritable_accessor :trust_message
          read_inheritable_attribute(:trust_message) || write_inheritable_attribute(:trust_message,
                                                                             "This web site is requesting your trust.")
          delegate :igb?, :to => :igb
          before_filter :detect_igb

          class << self
            def requires_trust(message = trust_message)
              self.trust_message = message if message != trust_message
              before_filter :require_trust
            end
  
            def prefers_trust(message = trust_message)
              self.trust_message = message if message != trust_message
              before_filter :prefer_trust
            end
          end
        end
      end
      
      def igb
        @igb ||= Eve::Trust::IgbInterface.new(request)
      end

      def require_trust(trust_message = self.class.trust_message)
        if igb? && !igb.trusted?
          render :text => "<body onload=\"CCPEVE.requestTrust('http://#{request.host_with_port}')\">", :layout => false
        end
        true
      end
      
      def prefer_trust(trust_message = self.class.trust_message)
        if igb? && !igb.trusted?
          deliver_trust_message(trust_message)
        end
        true
      end

      def deliver_trust_message(trust_message = self.class.trust_message)
        trust_uri = "http://#{request.host_with_port}/"
        headers['Eve.trustme'] = "#{trust_uri}::#{trust_message}"
      end

      def detect_igb
        if igb.igb?
          set_igb_or_default
        end
      end

      def set_igb_or_default
        if default_template_exists? :igb
          set_igb
        end
      end

      def set_igb
        request.format = :igb
        igb
      end
      
      unless defined?(default_template_name)
        def default_template_name
          # FIXME: I didn't check how Rails3 actually decides which template to render --
          # we should really follow the same rules so we don't break anything unintentionally.
          action_name
        end
      end

      def default_template_exists?(format = request.format)
        formats = lookup_context.formats
        lookup_context.formats = [format]
        lookup_context.exists?(default_template_name, controller_path)
      ensure
        lookup_context.formats = formats
      end
    end
  end
end
