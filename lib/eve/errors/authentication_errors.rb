module Eve
  module Errors
    # 2xx - authentication/security/credentials error
    class AuthenticationError < StandardError; end

    module AuthenticationErrors
      # 200 - Security level not high enough.
      class InadequateSecurityLevel < AuthenticationError; end
      # 201 - Character does not belong to account.
      class WrongAccount < AuthenticationError; end
      # 202 - Cached API key authentication failure.
      class CachedKeyAuthFailure < AuthenticationError; end
      # 203 - Authentication failure.
      # 204 - Authentication failure.
      # 210 - Authentication failure.
      class AuthenticationFailure < AuthenticationError; end
      # 205 - Authentication failure (final pass).
      # 212 - Authentication failure (final pass).
      class LastAuthenticationFailure < AuthenticationError; end
      # 207 - Not available for NPC corporations.
      class NotAvailable < AuthenticationError; end
      # 206 - Character must have Accountant or Junior Accountant roles.
      # 208 - Character must have Accountant, Junior Accountant, or Trader roles.
      # 209 - Character must be a Director or CEO.
      # 213 - Character must have Factory Manager role.
      class MissingRoles < AuthenticationError; end
      # 211 - Login denied by account status.
      class LoginDenied < AuthenticationError; end
      # 214 - Corporation is not part of alliance.
      class NotInAlliance < AuthenticationError; end
    end
  end
end
