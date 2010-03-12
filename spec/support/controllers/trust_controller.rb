class TrustController < ApplicationController
  requires_trust

  def index
    render :nothing => true
  end
end
