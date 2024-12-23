abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class AuthEmptyState extends AuthState {}

class AuthErrorState extends AuthState {
  String errorMessage;
  AuthErrorState({required this.errorMessage});
}
