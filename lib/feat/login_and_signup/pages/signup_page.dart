import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';

class SignUpPage extends StatefulWidget {
  final AuthBloc bloc;
  const SignUpPage({super.key, required this.bloc});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, UserAuthState>(
      listener: (context, state) {
        if (state is UserAuthEmptyState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "The Above fields are empty please check and try again!")));
        }
        // if (state is UserAuthenticatedState) {
        //   Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (context) => const LandingHomepage()));
        // }
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserAuthenticatedState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LandingHomepage()));
        }
        return Column(
          children: [
            const SizedBox(height: 15),
            Card(
              elevation: 20,
              shadowColor: const Color(0xffFFEB3B).withOpacity(0.8),
              color: const Color(0xffE8D3A4),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE8D3A4),
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Card(
              elevation: 20,
              shadowColor: const Color(0xffFFEB3B).withOpacity(0.8),
              color: const Color(0xffE8D3A4),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE8D3A4),
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: TextFormField(
                  controller: password,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Card(
              elevation: 20,
              shadowColor: const Color(0xffFFEB3B).withOpacity(0.8),
              color: const Color(0xffE8D3A4),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE8D3A4),
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: TextFormField(
                  controller: passwordConfirm,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                if (email.text.toString().isEmpty ||
                    password.text.toString().isEmpty) {
                  BlocProvider.of<AuthBloc>(context).add(AuthEmptyEvent());
                } else {
                  try {
                    context.read<AuthBloc>().add(AuthSignUpClickEvent(
                        email: email.text, password: password.text));
                  } catch (e) {
                    throw Exception(e);
                  }
                }
              },
              child: Card(
                elevation: 20,
                shadowColor: const Color(0xffFFEB3B).withOpacity(0.8),
                color: const Color(0xffE8D3A4),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffE8D3A4),
                      borderRadius: BorderRadius.circular(20)),
                  height: 70,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: const Center(
                      child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2E7D32)),
                  )),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
