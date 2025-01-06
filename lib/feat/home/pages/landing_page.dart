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
  void initState() {
    context.read<CartBloc>();
    super.initState();
  }

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
                      padding: const EdgeInsets.only(bottom: 5),
                      itemCount: pizza.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 8.1 / 16),
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
                          child: SizedBox(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailView(
                                      image: pizzaList[index],
                                      pizza: pizza[index],
                                    ),
                                  )),
                              child: Column(
                                children: [
                                  Image.asset(pizzaList[index]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 10, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height:
                                              GlobalSetHeightWidth.getHeight(
                                                      context) *
                                                  0.02,
                                          width: GlobalSetHeightWidth.getWidth(
                                                  context) *
                                              0.15,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: Text(
                                            pizza[index].isVegan
                                                ? 'VEG'
                                                : "NON-VEG",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          )),
                                        ),
                                        Container(
                                          height:
                                              GlobalSetHeightWidth.getHeight(
                                                      context) *
                                                  0.02,
                                          width: GlobalSetHeightWidth.getWidth(
                                                  context) *
                                              0.2,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: Text(
                                            pizza[index].isVegan
                                                ? "Extra cheese"
                                                : "100% Halal",
                                            style: const TextStyle(
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
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pizza[index]
                                                  .toppings
                                                  .map((e) => e)
                                                  .join()
                                                  .replaceAll(' ', ', ')
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (pizza[index].discount > 0)
                                              Text(
                                                "\$${pizza[index].discount.toString()}",
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            Text("\$${pizza[index].price}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    decoration:
                                                        pizza[index].discount >
                                                                0
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16))
                                          ],
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        onPressed: () async {
                                          context.read<CartBloc>().add(
                                              CartAddEvent(
                                                  price: state
                                                      .pizzaModel[index].price,
                                                  name: state
                                                      .pizzaModel[index].name,
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
