abstract class Error {
  int status;
  String message;
  Error({this.status, this.message});
}

// USER ERRORS
class SignUpError extends Error {
  SignUpError(status, message) : super(status: status, message: message);
}

class SignInError extends Error {
  SignInError(status, message) : super(status: status, message: message);
}

// TRANSACTION ERRORS
class TransactionError extends Error {
  TransactionError(status, message) : super(status: status, message: message);
}

//General Failures
class NetworkError extends Error {
  NetworkError() : super(status: 500, message: 'Device is not connected to the internet');
}

