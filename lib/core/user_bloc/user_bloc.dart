import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthRepository authRepo;
  AuthBloc({required this.authRepo}) : super(UnAuthenticatedState()) {
    on<AuthSignInClickEvent>(
      (event, emit) async {
        try {
          User? user = await authRepo.signIn(
              email: event.email, password: event.password);
          if (user != null) {
            emit(AuthLoadingState());
            emit(AuthSuccessState());
          }
        } catch (e) {
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
    on<AuthSignUpClickEvent>(
      (event, emit) async {
        try {
          User? user = await authRepo.signUp(
              email: event.email, password: event.password);
          if (user != null) {
            print("object");
            emit(AuthSuccessState());
          }
        } catch (e) {
          print("catch user- $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
    on<AuthEmptyEvent>((event, emit) async {
      emit(AuthEmptyState());
    });
  }
}
