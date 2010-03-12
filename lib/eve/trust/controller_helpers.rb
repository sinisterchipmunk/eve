module Eve
  module Trust
    module ControllerHelpers
      # None of this exists unless ActionController exists first.
      if defined?(ActionController) && defined?(ActionController::Base)
        class ::ApplicationController < ActionController::Base
          hide_action :trust_message, :trust_message=, :require_trust, :detect_igb, :template_exists?,
                      :set_igb_or_default, :default_template_exists?, :mock_methods_for_testing!,
                      :igb
          class_inheritable_accessor :trust_message
          read_inheritable_attribute(:trust_message) || write_inheritable_attribute(:trust_message,
                                                                      "This web site is requesting your trust.")
          attr_reader :igb
          before_filter :detect_igb

          def require_trust
            if igb.igb? && !igb.trusted?
              trust_uri = "http://#{request.host}/"
              head 'eve.trustme' => "#{trust_uri}::#{trust_message}"
              return false
            end
            true
          end

          def detect_igb
            @igb = Eve::Trust::IgbInterface.new(request)
            mock_methods_for_testing! if request.headers['mock_methods']
            if igb.igb?
              set_igb_or_default
            end
          end

          def set_igb_or_default
            if default_template_exists? :igb
              request.format = :igb
            end
          end

          def default_template_exists?(format = response.template.template_format)
            template_exists?(default_template_name, format)
          end

          def template_exists?(template_name, format = response.template.template_format)
            self.view_paths.find_template(template_name, format)
          rescue ActionView::MissingTemplate, Errno::ENOENT
            false
          end

          # a quick and dirty mocking solution.
          def mock_methods_for_testing! #:nodoc:
            request.headers['mock_methods'].each do |method_name, return_value|
              (class << self; self; end).instance_eval do
                define_method(method_name) { |*not_used| return_value }
              end
            end
          end

          class << self
            def requires_trust(message = trust_message)
              self.trust_message = message if message != trust_message
              before_filter :require_trust
            end
          end
        end
      end
    end
  end
end
