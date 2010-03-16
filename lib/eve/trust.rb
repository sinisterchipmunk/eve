require 'eve/trust/mime_types'
require 'eve/trust/controller_helpers'
require 'eve/trust/igb_interface'

module Eve
  # == Trust
  # The primary purpose for the ActionController is to figure out which View should be rendered, and what data to send
  # to that View. In keeping with this design, a few helper methods have been established that allow you to establish
  # trust with the In-Game Browser (IGB), which in turn provides access to more useful information such as the player's
  # current location. To establish trust with a compatible browser, simply add one line to your controller:
  #
  #  class AnyController < ApplicationController
  #    requires_trust
  #  end
  #
  # This will cause the in-game browser to prompt the user, asking him/her to complete the handshake. If they refuse,
  # the page will not load. To establish _optional_ trust -- that is, to allow the page to load even if the user hasn't
  # granted the trust request -- you can use +prefers_trust+ instead:
  #
  #  class AnyController < ApplicationController
  #    prefers_trust
  #  end
  #
  # Both methods also accept a custom trust request message that will be shown to the user when they are prompted:
  #
  #  class AnyController < ApplicationController
  #    prefers_trust "To take full advantage of the features on this site, please grant this trust request."
  #  end
  #
  # == IGB Headers
  # After trust has been established, the IGB sends additional content headers to the server with every request. These
  # headers contain the most up-to-date information regarding the current user, his/her location, his/her character ID,
  # and so on. The character ID could, for example, be used in conjunction with Eve::API to show the character's
  # portrait in a forum.
  #
  # To gain access to this extra information, use the +igb+ method:
  #
  #  class AnyController < ApplicationController
  #    . . .
  #    def index
  #      if igb? && igb.trusted?                  # if the client is using the IGB and trust has been established
  #        @solar_system = igb.solar_system_name  # then make a note of the current solar system
  #        @character_id = igb.character_id       # and the character ID
  #      else
  #        . . .                                  # handle a non-IGB browser such as Internet Explorer or Firefox.
  #      end
  #    end
  #
  # To find out which methods are exposed by the +igb+ method, take a look at Eve::Trust::IgbInterface.
  #
  # == View Format
  # In Rails, the View is usually rendered in HTML format. That means the view template is usually called
  # +some_action_name.html.erb+, where "some_action_name" is the name of the current action and "html" is the file
  # format. This library exposes a new format, "igb", which allows you to render an IGB-specific response. This response
  # is expected to be in IGB-compatible HTML format. Here's an example of what an IGB file might look like:
  #
  #  <%=link_to_evemail "Check Your Mail!"%>
  #  <%if igb.trusted?%>
  #    <p>Thanks for your trust! I see you're currently in <%=igb.solar_system_name%>.</p>
  #    <p>Here's some information about our secret headquarters:</p>
  #    <ul>
  #      <li><%=link_to_route "Click For Directions", "Jita"%></li>
  #      <li><%=link_to_map "Show On Map", "Jita"%></li>
  #    </ul>
  #  <%end%>
  #
  # For more information about the various helpers available to your IGB-specific views, take a look at
  # Eve::Helpers::JavascriptHelper.
  #
  # If the client is using the EVE In-Game Browser, then the "action_name.igb.erb" file will be automatically used,
  # provided it exists. If the matching file is not found, then "action_name.html.erb" will be used in its place, just
  # as if the client were using any other browser such as Internet Explorer or Firefox. You can also explicitly require
  # that the .igb file be rendered using the +set_igb+ method:
  #
  #  class AnyController < ApplicationController
  #    before_filter :check_for_igb_requirement
  #    private
  #    def check_for_igb_requirement
  #      if (some_condition)
  #        set_igb # force the IGB template for this action to be rendered
  #      end
  #    end
  #  end
  #
  module Trust

  end
end
