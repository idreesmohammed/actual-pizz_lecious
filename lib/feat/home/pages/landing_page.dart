import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_bloc.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_event.dart';
import 'package:pizz_lecious/feat/global_constants.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_bloc.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_event.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_state.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';
import 'package:pizz_lecious/feat/product_detail_view/pages/product_detail_view.dart';

class HomeActualLandingPage extends StatefulWidget {
  const HomeActualLandingPage({super.key});

  @override
  State<HomeActualLandingPage> createState() => _HomeActualLandingPageState();
}

class _HomeActualLandingPageState extends State<HomeActualLandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<PizzaBloc>()..add(PizzaGetEvent()),
      builder: (context, state) {
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
                    height: GlobalSetHeightWidth.getHeight(context) * 0.79,
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
                        if (pizzaDataList.isEmpty) {
                          pizzaDataList = pizza;
                          l.e(pizzaDataList.length);
                        }
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
                                        height: GlobalSetHeightWidth.getHeight(
                                                context) *
                                            0.02,
                                        width: GlobalSetHeightWidth.getWidth(
                                                context) *
                                            0.15,
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text(
                                          "NON-VEG",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        )),
                                      ),
                                      Container(
                                        height: GlobalSetHeightWidth.getHeight(
                                                context) *
                                            0.02,
                                        width: GlobalSetHeightWidth.getWidth(
                                                context) *
                                            0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text(
                                          "Extra cheese",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(pizza[index].name.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("description...."),
                                          Text("${pizza[index].price}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                            CartAddEvent(
                                                id: state
                                                    .pizzaModel[index].id));
                                      },
                                      icon: const Icon(
                                          color: Colors.black87,
                                          CupertinoIcons.add_circled_solid)),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
        }
        return const Center(child: Text('Something went wrong!'));
      },
    );
  }
}
