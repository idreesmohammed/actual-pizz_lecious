abstract class AuthEvent {}

class AuthSignInClickEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignInClickEvent({required this.email, required this.password});
}

class AuthSignUpClickEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpClickEvent({required this.email, required this.password});
}

class AuthLogOutEvent extends AuthEvent {}

class AuthEmptyEvent extends AuthEvent {}
