abstract class AuthEvent {}

class AuthSignInClickEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignInClickEvent({required this.email, required this.password});
}

class AuthSignUpClickEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  AuthSignUpClickEvent(
      {required this.email, required this.password, required this.name});
}

class AuthLogOutEvent extends AuthEvent {}

class AuthEmptyEvent extends AuthEvent {
  String message;
  AuthEmptyEvent({required this.message});
}

class AuthCheckRequestEvent extends AuthEvent {}
