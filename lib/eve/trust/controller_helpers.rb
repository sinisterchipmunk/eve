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
        p igb?, igb.trusted?
        if igb? && !igb.trusted?
          deliver_trust_message(trust_message)
          return false
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
        trust_uri = "http://#{request.host}/"
        head :unauthorized, 'Eve.trustme' => "#{trust_uri}::#{trust_message}"
      end

      def detect_igb
        mock_methods_for_testing! if Rails.env != 'production' && request.headers['mock_methods']
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
          action_name
        end
      end

      def default_template_exists?(format = response.template.template_format)
        template_exists?(default_template_name, format)
      end

      def template_exists?(template_name, format = response.template.template_format)
        lookup_context.find_template(template_name, format)
      rescue ActionView::MissingTemplate, Errno::ENOENT
        false
      end

      # a quick and dirty mocking solution. I should really make it better, but it works fine, and doesn't interfere
      # with anything in prod, so I'll procrastinate a bit.
      def mock_methods_for_testing! #:nodoc:
        request.headers['mock_methods'].each do |method_name, return_value|
          (class << self; self; end).instance_eval do
            define_method(method_name) { |*not_used| return_value }
          end
        end
      end
    end
  end
end
