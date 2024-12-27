import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthState {}

class UserAuthInitialState extends UserAuthState {}

class UserAuthenticatedState extends UserAuthState {
  final User user;
  UserAuthenticatedState({required this.user});
}

class LoadingState extends UserAuthState {}

class UserAuthEmptyState extends UserAuthState {
  String errorMessage;
  UserAuthEmptyState({required this.errorMessage});
}

class UserUnAuthenticatedState extends UserAuthState {}

class UserSignedUpSuccessful extends UserAuthState {
  final User user;
  UserSignedUpSuccessful({required this.user});
}

class AuthErrorState extends UserAuthState {
  String errorMessage;
  AuthErrorState({required this.errorMessage});
}
