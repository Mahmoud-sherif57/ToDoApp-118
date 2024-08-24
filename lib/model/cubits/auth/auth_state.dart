
sealed class AuthState {}
final class TogglePasswordState extends AuthState {}

final class RegisterLoadingState extends AuthState{}

final class RegisterSuccessState extends AuthState{}

final class RegisterErrorState extends AuthState{
  final String message;
  RegisterErrorState(this.message);
}

final class InitialAuthState extends AuthState {}

final class LoggingLoadingState extends AuthState {}

final class LoggingSuccessfulState extends AuthState {}

final class LoggingErrorState extends AuthState {
  // we create contractor to emit the error message inside to the user .
  final String message;
  LoggingErrorState(this.message);
}


