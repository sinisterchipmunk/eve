class TrustController < ActionController::Base
  requires_trust

  def index
    render :nothing => true
  end
end
