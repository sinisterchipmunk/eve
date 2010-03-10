module Eve
  module Errors
    # 9xx - Miscellaneous
    class MiscellaneousError < StandardError; end

    module MiscellaneousErrors
      # 900 - Beta in progress, access denied.
      class BetaInProgress < MiscellaneousError; end
      # 901 - Web site database temporarily disabled.
      class SiteDatabaseDisabled < MiscellaneousError; end
      # 902 - EVE backend database temporarily disabled.
      class BackendDatabaseDisabled < MiscellaneousError; end
      # 903 - Rate limited [#]: please obey all cachedUntil timers.
      class RateLimited < MiscellaneousError; end
      # 999 - User forced test error condition.
      class TestErrorForced < MiscellaneousError; end
    end
  end
end
