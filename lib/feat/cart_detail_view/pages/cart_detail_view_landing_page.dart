import 'package:flutter/material.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/address_and_payment_details/pages/payment_landing_page.dart';
import 'package:pizz_lecious/feat/global_constants.dart';

class CartDetailViewLandingPage extends StatefulWidget {
  const CartDetailViewLandingPage({super.key});

  @override
  State<CartDetailViewLandingPage> createState() =>
      _CartDetailViewLandingPageState();
}

class _CartDetailViewLandingPageState extends State<CartDetailViewLandingPage> {
  ValueNotifier<int> qty = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            height: GlobalSetHeightWidth.getHeight(context) * 0.8,
            child: ListView.builder(
              itemCount: addedProductId.length,
              itemBuilder: (context, index) {
                qty.value = pizzaDataList[index].qty;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: GlobalSetHeightWidth.getHeight(context) * 0.1,
                    width: GlobalSetHeightWidth.getWidth(context),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Text((pizzaDataList
                            .firstWhere((e) => e.id == addedProductId[index])
                            .name)),
                        Text((pizzaDataList
                            .firstWhere((e) => e.id == addedProductId[index])
                            .price
                            .toString())),
                        IconButton(
                            onPressed: () {
                              qty.value--;
                            },
                            icon: const Icon(Icons.minimize_outlined)),
                        Text((qty.value + 1).toString()),
                        IconButton(
                            onPressed: () {
                              qty.value++;
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                  ),
                );
              },
            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Proceed to checkout',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Cash On Delivery",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PaymentLandingPage()));
                                          },
                                          child: const Text(
                                            "Card",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
