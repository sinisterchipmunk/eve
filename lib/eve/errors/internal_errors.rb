module Eve
  module Errors
    # 5xx - Internal error (we did something bad)
    class InternalError < StandardError; end

    module InternalErrors
      # 500 - GetName(#) is invalid or not loaded.
      # 501 - GetID(#) is invalid or not loaded.
      class InvalidOrNotLoaded < InternalError; end
      # 502 - CacheUtil(#) seems to not be in the configuration.
      class CacheUtilMissing < InternalError; end
      # 503 - GetSkillpointsForLevel(#, #): invalid input.
      class InvalidInput < InternalError; end
      # 504 - GetRace(#): invalid race.
      class InvalidRace < InternalError; end
      # 505 - GetGender(#): invalid gender.
      class InvalidGender < InternalError; end
      # 506 - GetBloodline(#): invalid bloodline.
      class InvalidBloodline < InternalError; end
      # 507 - GetAttribute(#): invalid attribute.
      class InvalidAttribute < InternalError; end
      # 508 - GetRefType(#): invalid reftype.
      class InvalidRefType < InternalError; end
      # 509 - attributeID # has null data components.
      class NullAttributeID < InternalError; end
      # 510 - Character does not appear to have a corporation.  Not loaded?
      class MissingCorporation < InternalError; end
      # 511 - AccountCanQuery(#): invalid accountKey.
      class InvalidAccountKey < InternalError; end
      # 512 - Invalid charID passed to CharData.GetCharacter()
      class InvalidCharID < InternalError; end
      # 513 - Failed to get character roles in corporation.
      class RolesQueryFailure < InternalError; end
      # 514 - Invalid corpID passed to CorpData.GetCorporation().
      class InvalidCorpID < InternalError; end
      # 515 - Invalid userID and/or apiKey passed to UserData.GetUser().
      class InvalidUserID < InternalError; end
      # 516 - Failed getting user information.
      class UserInformationFailure < InternalError; end
      # 517 - CSV header/row count mismatch.
      class CSVMismatch < InternalError; end
      # 518 - Unable to get current TQ time.
      class TQTimeFailure < InternalError; end
      # 519 - Failed getting starbase detail information.
      class StarbaseDetailFailure < InternalError; end
      # 520 - Unexpected failure accessing database.
      class UnexpectedDatabaseFailure < InternalError; end
      # 521 - Invalid username and/or password passed to UserData.LoginWebUser().
      class InvalidCredentials < InternalError; end
      # 522 - Failed getting character information.
      class CharacterInformationFailure < InternalError; end
      # 523 - Failed getting corporation information.
      class CorporationInformationFailure < InternalError; end
      # 524 - Failed getting faction member information.
      class FactionMemberInformationFailure < InternalError; end
      # 525 - Failed getting medal information.
      class MedalInformationFailure < InternalError; end
      # 526 - Notifications for this character is not yet accessible.
      class NotificationsNotAvailable < InternalError; end
      # 527 - Mail for this character is not yet accessible.
      class MailNotAvailable < InternalError; end
    end
  end
end
