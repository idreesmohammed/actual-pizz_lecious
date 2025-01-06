import 'package:flutter/material.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';

class ProductDetailView extends StatelessWidget {
  final PizzaModel pizza;
  final String image;
  const ProductDetailView(
      {super.key, required this.pizza, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: SizedBox(
                height: GlobalSetHeightWidth.getHeight(context) * 0.4,
                child: Center(
                  child: Image.asset(
                      'assets/whole-cheese-pizza-with-slice-removebg-preview.png'),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 5, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pizza.name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          if (pizza.discount > 0)
                            Text(
                              "\$${pizza.discount.toString()}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(pizza.price.toString(),
                          style: TextStyle(
                              decoration: pizza.discount > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5, right: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Toppings',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pizza.toppings.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Chip(
                                            elevation: 10,
                                            backgroundColor: Theme.of(context)
                                                .primaryColorLight,
                                            label: Text(
                                              pizza.toppings[index],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ))));
                              },
                            ),
                          ),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
