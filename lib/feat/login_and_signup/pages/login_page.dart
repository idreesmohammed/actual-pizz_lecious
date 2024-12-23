import 'package:flutter/material.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';

class SignInPage extends StatefulWidget {
  final AuthBloc bloc;
  const SignInPage({super.key, required this.bloc});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        const SizedBox(height: 100),
        InkWell(
          onTap: () =>
              email.text.toString().isEmpty || password.text.toString().isEmpty
                  ? widget.bloc.add(AuthEmptyEvent())
                  : widget.bloc.add(AuthSignInClickEvent(
                      email: email.text, password: password.text)),
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
        )
      ],
    );
  }
}
