import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_repository.dart';
import 'package:pizz_lecious/feat/login_and_signup/pages/login_page.dart';
import 'package:pizz_lecious/feat/login_and_signup/pages/signup_page.dart';

class LoginSignupLandingpage extends StatefulWidget {
  const LoginSignupLandingpage({super.key});

  @override
  State<LoginSignupLandingpage> createState() => _LoginSignupLandingpageState();
}

class _LoginSignupLandingpageState extends State<LoginSignupLandingpage>
    with TickerProviderStateMixin {
  late AuthBloc bloc;
  late TabController tabBarController;
  @override
  void initState() {
    tabBarController = TabController(initialIndex: 0, length: 2, vsync: this);
    bloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2C27D),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.8,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TabBar(
                            indicatorColor: const Color(0xffFF5722),
                            controller: tabBarController,
                            unselectedLabelColor: Colors.grey,
                            labelColor: const Color(0xffFFEB3B),
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("Sign in",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("Sign up",
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                        ),
                        BlocProvider(
                          create: (context) => AuthBloc(
                              authRepo:
                                  RepositoryProvider.of<UserAuthRepository>(
                                      context)),
                          child: Expanded(
                              child: TabBarView(
                            clipBehavior: Clip.antiAlias,
                            controller: tabBarController,
                            children: [
                              SignInPage(bloc: bloc),
                              SignUpPage(bloc: bloc)
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  buildSignInPage(AuthBloc bloc) {
    final email = TextEditingController();
    final password = TextEditingController();
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
          onTap: () => context.read<AuthBloc>().add(
              AuthSignInClickEvent(email: email.text, password: password.text)),
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
