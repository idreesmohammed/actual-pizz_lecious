import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_repository.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              authRepo: RepositoryProvider.of<UserAuthRepository>(context))
            ..add(AuthCheckRequestEvent()),
        ),
        BlocProvider(
          create: (context) => PizzaBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
        )),
        locale: const Locale('en', 'us'),
        title: "Pizza Lecious :-)",
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthBloc, UserAuthState>(
          listener: (context, state) {
            if (state is UserAuthenticatedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingHomepage()));
            }
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      state.errorMessage.replaceAll('Exception:', 'Error-'))));
            }
            if (state is UserUnAuthenticatedState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text("Logged out Successfully!")));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginSignupLandingpage()));
            }
            if (state is UserAuthEmptyState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("email or password field is empty")));
            }
          },
          builder: (context, state) {
            // if (state is UserUnAuthenticatedState) {
            //   print("no user");
            //   const LoginSignupLandingpage();
            // }
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}