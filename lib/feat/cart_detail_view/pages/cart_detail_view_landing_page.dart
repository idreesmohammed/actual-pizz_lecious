import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/address_and_payment_details/pages/payment_landing_page.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_bloc.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_event.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_state.dart';
import 'package:pizz_lecious/feat/cart_detail_view/pages/address_details_view.dart';
import 'package:pizz_lecious/feat/cart_detail_view/pages/no_products_view.dart';
import 'package:pizz_lecious/feat/global_constants.dart';

class CartDetailViewLandingPage extends StatefulWidget {
  const CartDetailViewLandingPage({super.key});

  @override
  State<CartDetailViewLandingPage> createState() =>
      _CartDetailViewLandingPageState();
}

class _CartDetailViewLandingPageState extends State<CartDetailViewLandingPage> {
  @override
  void initState() {
    getTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<CartBloc, CartState>(
          bloc: context.read<CartBloc>(),
          listener: (context, state) {
            if (state is CartEmptyState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NoProductsView()));
            }
          },
          builder: (context, state) {
            state as CartAddedState;
            return SizedBox(
              height: GlobalSetHeightWidth.getHeight(context) * 0.8,
              child: ListView.builder(
                itemCount: (state).cartList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      height: GlobalSetHeightWidth.getHeight(context) * 0.12,
                      width: GlobalSetHeightWidth.getWidth(context),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                (state).cartList[index].productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                  (state.cartList[index].productPrice *
                                          state.cartList[index].qty)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Text(
                                'Qty: ${state.cartList[index].qty.toString()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                        CartProductQtyDecrementEvent(
                                            index: index,
                                            qty: state.cartList[index].qty));
                                    setState(() {
                                      getTotal();
                                    });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.minus,
                                    size: 20,
                                  )),
                              Text(
                                'x${state.cartList[index].qty.toString()}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    l.e(index);
                                    context.read<CartBloc>().add(
                                        CartProductQtyIncementEvent(
                                            index: index,
                                            qty: state.cartList[index].qty));
                                    setState(() {
                                      getTotal();
                                    });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 20,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    context
                                        .read<CartBloc>()
                                        .add(CartProductRemoveEvent(
                                          index: index,
                                        ));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Item removed successfully!")));
                                    if (state.cartList.length == 1) {
                                      context
                                          .read<CartBloc>()
                                          .add(CartReInitializeCartEvent());
                                    }
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: 20,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: GlobalSetHeightWidth.getHeight(context) * 0.1,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.dollarSign,
                                color: Theme.of(context).primaryColorDark,
                                size: 20),
                            Text(
                              getTotal().toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Proceed to checkout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddressDetailsView(
                                                            paymentType: "CASH",
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(FontAwesomeIcons
                                                    .dollarSign),
                                                Text(
                                                  "Cash",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ],
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PaymentLandingPage()));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.credit_card),
                                                Text(
                                                  "Card",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ));
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            fill: 1,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  double getTotal() {
    return cartList.fold(
        0, (sum, product) => sum + (product.productPrice * product.qty));
  }
}
