require 'eve/errors/user_input_errors'
require 'eve/errors/authentication_errors'
require 'eve/errors/internal_errors'
require 'eve/errors/miscellaneous_errors'

module Eve
  module Errors
    # Raised when a rowset cannot be processed.
    class InvalidRowset < StandardError; end

    unless defined?(API_ERROR_MAP)
      API_ERROR_MAP = {
        '1xx' => Eve::Errors::UserInputError,
        100 => Eve::Errors::UserInputErrors::WalletNotLoaded,
        101 => Eve::Errors::UserInputErrors::WalletExhausted,
        102 => Eve::Errors::UserInputErrors::WalletPreviouslyLoaded,
        103 => Eve::Errors::UserInputErrors::RetryLater,
        104 => Eve::Errors::UserInputErrors::KeyNotFound,
        105 => Eve::Errors::UserInputErrors::InvalidCharacterID,
        106 => Eve::Errors::UserInputErrors::MissingUserID,
        107 => Eve::Errors::UserInputErrors::InvalidBeforeRefID,
        108 => Eve::Errors::UserInputErrors::InvalidAccountKey,
        109 => Eve::Errors::UserInputErrors::AccountKeyOutOfBounds,
        110 => Eve::Errors::UserInputErrors::InvalidBeforeTransID,
        111 => Eve::Errors::UserInputErrors::InvalidInteger,
        112 => Eve::Errors::UserInputErrors::VersionMismatch,
        113 => Eve::Errors::UserInputErrors::VersionEscalationNotAllowed,
        114 => Eve::Errors::UserInputErrors::InvalidItemID,
        115 => Eve::Errors::UserInputErrors::AssetsAlreadyDownloaded,
        116 => Eve::Errors::UserInputErrors::IndustryJobsAlreadyDownloaded,
        117 => Eve::Errors::UserInputErrors::MarketOrdersAlreadyDownloaded,
        118 => Eve::Errors::UserInputErrors::KillsNotLoaded,
        119 => Eve::Errors::UserInputErrors::KillsExhausted,
        120 => Eve::Errors::UserInputErrors::KillsPreviouslyLoaded,
        121 => Eve::Errors::UserInputErrors::InvalidBeforeKillID,
        122 => Eve::Errors::UserInputErrors::InvalidNameList,
        123 => Eve::Errors::UserInputErrors::InvalidIDList,
        124 => Eve::Errors::UserInputErrors::CharacterNotEnlisted,
        125 => Eve::Errors::UserInputErrors::CorporationNotEnlisted,

        '2xx' => Eve::Errors::AuthenticationError,
        200 => Eve::Errors::AuthenticationErrors::InadequateSecurityLevel,
        201 => Eve::Errors::AuthenticationErrors::WrongAccount,
        202 => Eve::Errors::AuthenticationErrors::CachedKeyAuthFailure,
        203 => Eve::Errors::AuthenticationErrors::AuthenticationFailure,
        204 => Eve::Errors::AuthenticationErrors::AuthenticationFailure,
        205 => Eve::Errors::AuthenticationErrors::LastAuthenticationFailure,
        206 => Eve::Errors::AuthenticationErrors::MissingRoles,
        207 => Eve::Errors::AuthenticationErrors::NotAvailable,
        208 => Eve::Errors::AuthenticationErrors::MissingRoles,
        209 => Eve::Errors::AuthenticationErrors::MissingRoles,
        210 => Eve::Errors::AuthenticationErrors::AuthenticationFailure,
        211 => Eve::Errors::AuthenticationErrors::LoginDenied,
        212 => Eve::Errors::AuthenticationErrors::LastAuthenticationFailure,
        213 => Eve::Errors::AuthenticationErrors::MissingRoles,
        214 => Eve::Errors::AuthenticationErrors::NotInAlliance,


        '5xx' => Eve::Errors::InternalError,
        500 => Eve::Errors::InternalErrors::InvalidOrNotLoaded,
        501 => Eve::Errors::InternalErrors::InvalidOrNotLoaded,
        502 => Eve::Errors::InternalErrors::CacheUtilMissing,
        503 => Eve::Errors::InternalErrors::InvalidInput,
        504 => Eve::Errors::InternalErrors::InvalidRace,
        505 => Eve::Errors::InternalErrors::InvalidGender,
        506 => Eve::Errors::InternalErrors::InvalidBloodline,
        507 => Eve::Errors::InternalErrors::InvalidAttribute,
        508 => Eve::Errors::InternalErrors::InvalidRefType,
        509 => Eve::Errors::InternalErrors::NullAttributeID,
        510 => Eve::Errors::InternalErrors::MissingCorporation,
        511 => Eve::Errors::InternalErrors::InvalidAccountKey,
        512 => Eve::Errors::InternalErrors::InvalidCharID,
        513 => Eve::Errors::InternalErrors::RolesQueryFailure,
        514 => Eve::Errors::InternalErrors::InvalidCorpID,
        515 => Eve::Errors::InternalErrors::InvalidUserID,
        516 => Eve::Errors::InternalErrors::UserInformationFailure,
        517 => Eve::Errors::InternalErrors::CSVMismatch,
        518 => Eve::Errors::InternalErrors::TQTimeFailure,
        519 => Eve::Errors::InternalErrors::StarbaseDetailFailure,
        520 => Eve::Errors::InternalErrors::UnexpectedDatabaseFailure,
        521 => Eve::Errors::InternalErrors::InvalidCredentials,
        522 => Eve::Errors::InternalErrors::CharacterInformationFailure,
        523 => Eve::Errors::InternalErrors::CorporationInformationFailure,
        524 => Eve::Errors::InternalErrors::FactionMemberInformationFailure,
        525 => Eve::Errors::InternalErrors::MedalInformationFailure,
        526 => Eve::Errors::InternalErrors::NotificationsNotAvailable,
        527 => Eve::Errors::InternalErrors::MailNotAvailable,

        '9xx' => Eve::Errors::MiscellaneousError,
        900 => Eve::Errors::MiscellaneousErrors::BetaInProgress,
        901 => Eve::Errors::MiscellaneousErrors::SiteDatabaseDisabled,
        902 => Eve::Errors::MiscellaneousErrors::BackendDatabaseDisabled,
        903 => Eve::Errors::MiscellaneousErrors::RateLimited,
        999 => Eve::Errors::MiscellaneousErrors::TestErrorForced,
      }

      API_ERROR_MAP.freeze
    end
  end
end
