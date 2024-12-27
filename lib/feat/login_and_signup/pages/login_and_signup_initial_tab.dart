import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_repository.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';
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
        body: BlocListener<AuthBloc, UserAuthState>(
          listener: (context, state) {
            if (state is UserAuthenticatedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingHomepage()));
            }
          },
          child: SingleChildScrollView(
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
          ),
        ));
  }
}
