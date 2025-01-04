import 'package:flutter/material.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';

class NoProductsView extends StatelessWidget {
  const NoProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 20,
              color: Theme.of(context).primaryColor,
              surfaceTintColor: Theme.of(context).primaryColor,
              child: Container(
                height: GlobalSetHeightWidth.getHeight(context) * 0.45,
                width: GlobalSetHeightWidth.getWidth(context) * 0.8,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset('assets/emptycart.png'),
                    ),
                    const Text(
                      "Your Cart is Empty!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingHomepage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(20)),
                  height: GlobalSetHeightWidth.getHeight(context) * 0.05,
                  width: GlobalSetHeightWidth.getWidth(context) * 0.9,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add your products",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
