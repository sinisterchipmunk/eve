ActiveSupport::Deprecation.deprecate_methods(Eve::Trust::ControllerHelpers, {
  :prefer_trust  => "The EVE IGB no longer accepts trust headers. Please use <%=request_trust%> in your view, instead."
})
