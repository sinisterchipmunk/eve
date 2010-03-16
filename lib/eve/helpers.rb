require 'eve/helpers/view_helper'
require 'eve/helpers/javascript_helper'

module Eve
  module Helpers
    if defined?(ActionView::Base)
      ActionView::Base.send(:include, Eve::Helpers::ViewHelper)
      ActionView::Base.send(:include, Eve::Helpers::JavascriptHelper)
    end
  end
end

