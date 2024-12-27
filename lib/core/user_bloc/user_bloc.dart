import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, UserAuthState> {
  final UserAuthRepository authRepo;
  AuthBloc({required this.authRepo}) : super(UserAuthInitialState()) {
    on<AuthCheckRequestEvent>((event, emit) async {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        emit(LoadingState());
        emit(UserAuthenticatedState(user: user));
      } else {
        emit(UserUnAuthenticatedState());
      }
    });
    on<AuthSignInClickEvent>(
      (event, emit) async {
        try {
          emit(LoadingState());
          final user = await authRepo.signIn(
              email: event.email, password: event.password);
          emit(UserAuthenticatedState(user: user));
        } catch (e) {
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
    on<AuthSignUpClickEvent>(
      (event, emit) async {
        try {
          emit(LoadingState());
          final user = await authRepo.signUp(
              email: event.email, password: event.password);

          if (user != null) {
            emit(UserAuthenticatedState(user: user));
          }
          print("hello try ");
        } catch (e) {
          print("hello catch $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
    on<AuthEmptyEvent>((event, emit) async {
      emit(UserAuthEmptyState());
    });
    on<AuthLogOutEvent>(
      (event, emit) async {
        await authRepo.logOut();
        emit(UserUnAuthenticatedState());
      },
    );
  }
}
