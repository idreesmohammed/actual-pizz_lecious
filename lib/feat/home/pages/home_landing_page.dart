import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/core/user_bloc/user_bloc.dart';
import 'package:pizz_lecious/core/user_bloc/user_event.dart';
import 'package:pizz_lecious/core/user_bloc/user_state.dart';
import 'package:pizz_lecious/core/user_model.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_bloc.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_event.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_state.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';
import 'package:pizz_lecious/feat/home/pages/product_detail_view.dart';
import 'package:pizz_lecious/feat/login_and_signup/pages/login_and_signup_initial_tab.dart';

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
    return BlocListener<PizzaBloc, PizzaState>(
      listener: (context, state) {
        if (state is PizzaUserLogOutState) {
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
                    context.read<PizzaBloc>().add(PizzaLogOutEvent());
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
          body: BlocConsumer<PizzaBloc, PizzaState>(
              bloc: context.read<PizzaBloc>()..add(PizzaGetEvent()),
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

                // if (state is UserUnAuthenticatedState) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text("Logged out Succssfully!")));
                //   Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const LoginSignupLandingpage()));
                // }
              },
              builder: (context, state) {
                if (state is PizzaLoadFailureState) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is PizzaLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is PizzaLoadedSuccessState) {
                  List<PizzaModel> pizza = state.pizzaModel;
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                GlobalSetHeightWidth.getHeight(context) * 0.79,
                            width: GlobalSetHeightWidth.getWidth(context),
                            child: GridView.builder(
                              itemCount: pizza.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 9 / 16),
                              itemBuilder: (context, index) {
                                return Material(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetailView(),
                                        )),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/whole-cheese-pizza-with-slice-removebg-preview.png'),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 10, right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: GlobalSetHeightWidth
                                                        .getHeight(context) *
                                                    0.02,
                                                width: GlobalSetHeightWidth
                                                        .getWidth(context) *
                                                    0.15,
                                                decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Center(
                                                    child: Text(
                                                  "NON-VEG",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                )),
                                              ),
                                              Container(
                                                height: GlobalSetHeightWidth
                                                        .getHeight(context) *
                                                    0.02,
                                                width: GlobalSetHeightWidth
                                                        .getWidth(context) *
                                                    0.2,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Center(
                                                    child: Text(
                                                  "Extra cheese",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                              pizza[index].name.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("description...."),
                                                  Text("${pizza[index].price}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  color: Colors.black87,
                                                  CupertinoIcons
                                                      .add_circled_solid)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Expanded(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Chip(label: Text("label1")),
                                  SizedBox(width: 6),
                                  Chip(label: Text("label1")),
                                  SizedBox(width: 6),
                                  Chip(label: Text("label1")),
                                  SizedBox(width: 6),
                                  Chip(label: Text("label1")),
                                  SizedBox(width: 6),
                                  Chip(label: Text("label1")),
                                  SizedBox(width: 6),
                                  Chip(label: Text("label1"))
                                ],
                              ),
                            ),
                          ))
                        ],
                      ));
                }
                return Text('somethingwent wrong');
              })),
    );
  }
}
