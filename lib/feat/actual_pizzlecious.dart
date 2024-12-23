import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_repository.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';
import 'package:pizz_lecious/feat/login_and_signup/pages/login_and_signup_initial_tab.dart';

class Pizzelicious extends StatelessWidget {
  const Pizzelicious({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserAuthRepository(),
      child: const ActualPizzeliciousApp(),
    );
  }
}

class ActualPizzeliciousApp extends StatelessWidget {
  const ActualPizzeliciousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          authRepo: RepositoryProvider.of<UserAuthRepository>(context)),
      child: MaterialApp(
        locale: const Locale('en', 'us'),
        title: "Pizza Lecious :-)",
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LandingHomepage()));
            }
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      state.errorMessage.replaceAll('Exception:', 'Error-'))));
            }
            if (state is UnAuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out Successfully!")));
            }
            if (state is AuthEmptyState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("email or password field is empty")));
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthSuccessState) {
              const LandingHomepage();
            }
            if (state is UnAuthenticatedState) {
              return const LoginSignupLandingpage();
            }
            if (state is AuthErrorState) {
              return const LoginSignupLandingpage();
            }
            if (state is AuthEmptyState) {
              return const LoginSignupLandingpage();
            } else {
              print("here");
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
