module Eve
  module Errors
    # 1xx - User Input Error
    class UserInputError < StandardError; end

    module UserInputErrors
      # 100 - Expected beforeRefID = 0: wallet not previously loaded.
      class WalletNotLoaded < UserInputError; end
      # 101 - Wallet exhausted: retry after #.
      class WalletExhausted < UserInputError; end
      # 102 - Expected beforeRefID [#], got [#]: wallet previously loaded.
      class WalletPreviouslyLoaded < UserInputError; end
      # 103 - Already returned one week of data: retry after #.
      class RetryLater < UserInputError; end
      # 104 - GetAccountByKey(#): key not found.
      class KeyNotFound < UserInputError; end
      # 105 - Invalid characterID.
      class InvalidCharacterID < UserInputError; end
      # 106 - Must provide userID parameter for authentication.
      class MissingUserID < UserInputError; end
      # 107 - Invalid beforeRefID provided.
      class InvalidBeforeRefID < UserInputError; end
      # 108 - Invalid accountKey provided.
      class InvalidAccountKey < UserInputError; end
      # 109 - Invalid accountKey: must be in the range 1000 to 1006.
      class AccountKeyOutOfBounds < UserInputError; end
      # 110 - Invalid beforeTransID provided.
      class InvalidBeforeTransID < UserInputError; end
      # 111 - '#' is not a valid integer.
      class InvalidInteger < UserInputError; end
      # 112 - Version mismatch.
      class VersionMismatch < UserInputError; end
      # 113 - Version escalation is not allowed at this time.
      class VersionEscalationNotAllowed < UserInputError; end
      # 114 - Invalid itemID provided.
      class InvalidItemID < UserInputError; end
      # 115 - Assets already downloaded: retry after #.
      class AssetsAlreadyDownloaded < UserInputError; end
      # 116 - Industry jobs already downloaded: retry after #.
      class IndustryJobsAlreadyDownloaded < UserInputError; end
      # 117 - Market orders already downloaded: retry after #.
      class MarketOrdersAlreadyDownloaded < UserInputError; end
      # 118 - Expected beforeKillID = 0: wallet not previously loaded.
      class KillsNotLoaded < UserInputError; end
      # 119 - Kills exhausted: retry after #.
      class KillsExhausted < UserInputError; end
      # 120 - Expected beforeKillID [#] but supplied [#]: kills previously loaded.
      class KillsPreviouslyLoaded < UserInputError; end
      # 121 - Invalid beforeKillID provided.
      class InvalidBeforeKillID < UserInputError; end
      # 122 - Invalid or missing list of names.
      class InvalidNameList < UserInputError; end
      # 123 - Invalid or missing list of IDs.
      class InvalidIDList < UserInputError; end
      # 124 - Character not enlisted in Factional Warfare.
      class CharacterNotEnlisted < UserInputError; end
      # 125 - Corporation not enlisted in Factional Warfare.
      class CorporationNotEnlisted < UserInputError; end
    end
  end
end

