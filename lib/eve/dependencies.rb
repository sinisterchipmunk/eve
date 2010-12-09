require 'net/http'
require 'hpricot'
require 'yaml'

require 'sc-core-ext'

gem_path = File.expand_path(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift gem_path

# moved to autoload to make gem more future-proof
#ActiveSupport::Dependencies.load_paths.unshift gem_path
#ActiveSupport::Dependencies.load_once_paths.unshift gem_path

module Eve
  autoload :Errors, "eve/errors"
  autoload :API, "eve/api"
  autoload :Errors, "eve/errors"
  autoload :JavascriptHelper, "eve/javascript_helper"
  autoload :Trust, "eve/trust"

  # Railtie for bootstrapping to Rails
  begin
    require 'rails'
    # we just required Rails -- are these next 3 necessary?
    require 'action_pack'
    require 'action_controller'
    require 'action_view'

    class Railtie < Rails::Railtie
      config.after_initialize do
        if defined?(Mime::Type)
          # *.igb.erb format
          Mime::Type.register_alias "text/html", :eve
          Mime::Type.register_alias "text/html", :igb
        end

        # controller extensions
        ActionController::Base.send(:include, Eve::Trust::ControllerHelpers)

        # view extensions
        ActionView::Base.send(:delegate, :igb,  :to => :controller)
        ActionView::Base.send(:delegate, :igb?, :to => :igb)
        ActionView::Base.send(:include, Eve::JavascriptHelper)
      end
    end
  rescue LoadError
    # no rails? no problem.
  end
end
