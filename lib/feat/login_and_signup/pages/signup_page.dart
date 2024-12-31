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
  final name = TextEditingController();
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, UserAuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is UserAuthEmptyState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is UserAuthenticatedState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LandingHomepage()));
        }

        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
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
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 20, left: 10),
                      hintText: "Enter your mail ID"),
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
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: IconButton(
                            onPressed: () => setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                }),
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      contentPadding: const EdgeInsets.only(top: 20, left: 10),
                      border: InputBorder.none,
                      hintText: "Enter your Password"),
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
                  obscureText: true,
                  controller: passwordConfirm,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20, left: 10),
                      border: InputBorder.none,
                      hintText: "Re-Enter your Password"),
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
                  controller: name,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 20, left: 10),
                      hintText: "How do we like to call you?"),
                ),
              ),
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                if (email.text.toString().isEmpty ||
                    password.text.toString().isEmpty ||
                    passwordConfirm.text.isEmpty ||
                    name.text.isEmpty) {
                  BlocProvider.of<AuthBloc>(context).add(AuthEmptyEvent(
                      message:
                          "The Above fields are empty please check and try again!"));
                } else if (password.text != passwordConfirm.text) {
                  BlocProvider.of<AuthBloc>(context).add(AuthEmptyEvent(
                      message:
                          "your password doesn't match with re confirming please check"));
                } else {
                  try {
                    context.read<AuthBloc>().add(AuthSignUpClickEvent(
                        email: email.text,
                        password: password.text,
                        name: name.text));
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
