import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';

class SignInPage extends StatefulWidget {
  final AuthBloc bloc;
  const SignInPage({super.key, required this.bloc});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, UserAuthState>(
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

        if (state is UserAuthInitialState) {
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
                        contentPadding: EdgeInsets.only(top: 15, left: 10),
                        border: InputBorder.none,
                        hintText: "Enter your registered mail ID"),
                  ),
                ),
              ),
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
                        contentPadding:
                            const EdgeInsets.only(top: 20, left: 10),
                        border: InputBorder.none,
                        hintText: "Enter your password"),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () {
                  if (email.text.toString().isEmpty ||
                      password.text.toString().isEmpty) {
                    BlocProvider.of<AuthBloc>(context).add(AuthEmptyEvent(
                        message:
                            "The Above fields are empty please check and try again!"));
                  } else {
                    try {
                      context.read<AuthBloc>().add(AuthSignInClickEvent(
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
                      "Sign In",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2E7D32)),
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New User? Swipe to ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
