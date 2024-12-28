import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_model.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/pages/landing_page.dart';
import 'package:pizz_lecious/feat/dessert_tab_view/pages/landing_page.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_bloc.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_event.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_state.dart';
import 'package:pizz_lecious/feat/home/constants/constants.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';
import 'package:pizz_lecious/feat/home/pages/landing_page.dart';
import 'package:pizz_lecious/feat/login_and_signup/pages/login_and_signup_initial_tab.dart';
import 'package:pizz_lecious/feat/product_detail_view/pages/product_detail_view.dart';

class LandingHomepage extends StatefulWidget {
  const LandingHomepage({super.key});

  @override
  State<LandingHomepage> createState() => _LandingHomepageState();
}

class _LandingHomepageState extends State<LandingHomepage> {
  late AuthBloc bloc;
  late PizzaBloc pizzaBloc;
  UserModel? user;
  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    pizzaBloc = context.read<PizzaBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, UserAuthState>(
      listener: (context, state) {
        if (state is UserUnAuthenticatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Logged out Succssfully!")));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginSignupLandingpage()));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOutEvent());
                  },
                  icon: const Icon(Icons.logout_sharp)),
            ],
            title: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 40,
                  child: Image.asset('assets/pizza.png'),
                ),
                const Text("PIZZA",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
              animationDuration: const Duration(milliseconds: 300),
              color: Theme.of(context).primaryColor,
              backgroundColor: Colors.transparent,
              height: 60,
              index: context.read<PizzaBloc>().initialIndex,
              onTap: (val) {
                BlocProvider.of<PizzaBloc>(context)
                    .add(PizzaOnTabChangeEvent(tab: val));
              },
              items: HomeConstants.navBarIcons),
          body: BlocConsumer<PizzaBloc, PizzaState>(
              bloc: pizzaBloc,
              listener: (context, state) {
                if (state is PizzaUserLogOutState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out Succssfully!")));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginSignupLandingpage()));
                }
              },
              builder: (context, state) {
                if (state is PizzaOnTabChangeState) {
                  if (state.tabChange == 1) {
                    return const AddOnLandingPage();
                  }
                  if (state.tabChange == 2) {
                    return const DessertLandingPage();
                  }
                  if (state.tabChange == 0) {
                    return const HomeActualLandingPage();
                  }
                }

                return const HomeActualLandingPage();
              })),
    );
  }
}
