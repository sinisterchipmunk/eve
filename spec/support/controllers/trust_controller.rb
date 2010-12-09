class TrustController < ActionController::Base
  prefers_trust
  #requires_trust

  def index
    render :nothing => true
  end
  
  def no_templates
    
  end
  
  def igb_only
    
  end
  
  def html_only
    
  end
  
  def html_and_igb
    
  end
end
