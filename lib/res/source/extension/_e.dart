part of source;

///
/// this file contains all the custom errors and exceptions:
///
/// ------------------------------------------------------------error:
/// [ImpossibleError]
///
/// [ParseEnumError]
/// [ParseStringError]
///
/// [HubAuthLoginError]
/// [HubStoreNotProvideError]
/// [HubStoreNoImplementationError]
///
/// [CustomError]
/// [StreamError]
/// [ScreenNotFoundError]
/// [TemplateError]
/// [OverlayEntryNotExistError]
/// [OverlayEntriesEmptyError]
/// [PropertyNotProvideError]
/// [AniControllerNoWidgetError]
///
/// [CoordinateError]
/// [CoordinateNotValidError]
/// [GraphConfigurationNoValidationError]
/// [PlanesAniControllerNotMotivatableError]
///
///
///
///
///
/// ------------------------------------------------------------exception:
/// [CustomException]
/// [CoordinateException]
///
/// [AuthException]
///
/// [AuthRegisterException]
/// [AuthLoginException]
/// [AuthLogoutException]
/// [AuthNoImplementationException]
///
/// [RegisterWeakPasswordException]
/// [RegisterEmailAlreadyInUseException]
/// [RegisterInvalidEmailException]
/// [LoginFailException]
/// [LoginIdpNotSignedException]
/// [LoginUserNotFoundException]
/// [LoginWrongPasswordException]
/// [LoginUserNotLoggedInException]
///
/// [StoreException]
///
/// [StoreModelNoIdException]
/// [StoreDataNotFoundException]
///
/// [ModelCanOnlyOnePreferStoreServiceException]
///
///
///
///
///
///
///

class ImpossibleError extends Error {}

class ParseEnumError extends Error {
  final Type type;

  ParseEnumError(this.type);

  @override
  String toString() => '$type not enum';
}

class ParseStringError extends Error {
  final String s;

  ParseStringError(this.s);

  @override
  String toString() => '$s not valid string';
}

class HubAuthLoginError extends Error {}

class HubStoreNotProvideError extends Error {}

class HubStoreNoImplementationError extends Error {}

class CustomError extends Error {
  final Object? error;
  @override
  final StackTrace? stackTrace;

  CustomError(this.error, {this.stackTrace});

  @override
  String toString() => error.toString();
}

class StreamError extends CustomError {
  StreamError(super.error, {super.stackTrace});
}

/// e for widget
class ScreenNotFoundError extends CustomError {
  ScreenNotFoundError(super.message);
}

/// e for material
class TemplateError extends Error {}

class OverlayEntryNotExistError extends Error {}

class OverlayEntriesEmptyError extends Error {}

class PropertyNotProvideError extends Error {}

class AniControllerNoWidgetError extends Error {}

/// e for custom usages
abstract class CoordinateError extends Error {}

class CoordinateNotValidError extends CoordinateError {}

class GraphConfigurationNoValidationError extends CoordinateError {}

class MationPlanesNotAnimatableError extends CustomError {
  MationPlanesNotAnimatableError()
      : super(
          "invalid to motivate 'PlanesAniController' without invoke 'motivate' method",
        );
}


///
///
/// -----
///
///

sealed class CustomException implements Exception {
  // String messageOf(BuildContext context);
}

sealed class CoordinateException implements CustomException {}

// invalid to have negative dimension
class CoordinateNegativeException extends CoordinateException {}

///
/// auth exception
///

sealed class AuthException implements CustomException {}

abstract class AuthRegisterException extends AuthException {}

abstract class AuthLoginException extends AuthException {}

abstract class AuthLogoutException extends AuthException {}

class AuthNoImplementationException extends AuthException {}

/// register
class RegisterWeakPasswordException extends AuthRegisterException {}

class RegisterEmailAlreadyInUseException extends AuthRegisterException {}

class RegisterInvalidEmailException extends AuthRegisterException {}

/// login
class LoginFailException extends AuthLoginException {}

class LoginIdpNotSignedException extends AuthLoginException {}

class LoginUserNotFoundException extends AuthLoginException {}

class LoginWrongPasswordException extends AuthLoginException {}

class LoginUserNotLoggedInException extends AuthLoginException {}

///
/// store exception
///

abstract class StoreException implements CustomException {}

class StoreModelNoIdException extends StoreException {}

class StoreDataNotFoundException extends StoreException {}

///
/// other
///

class ScreenNotInGraphException implements CustomException {}