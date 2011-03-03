ActiveSupport::Deprecation.deprecate_methods(Eve::Trust::ControllerHelpers, {
  :require_trust => "The EVE IGB no longer accepts trust headers. Please use <%=request_trust%> in your view, instead.",
  :prefer_trust  => "The EVE IGB no longer accepts trust headers. Please use <%=request_trust%> in your view, instead."
})
