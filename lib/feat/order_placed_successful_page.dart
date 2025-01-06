import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizz_lecious/feat/global_constants.dart';
import 'package:pizz_lecious/feat/home/pages/home_landing_page.dart';

class OrderPlacedSuccessfulPage extends StatefulWidget {
  const OrderPlacedSuccessfulPage({super.key});

  @override
  State<OrderPlacedSuccessfulPage> createState() =>
      _OrderPlacedSuccessfulPageState();
}

class _OrderPlacedSuccessfulPageState extends State<OrderPlacedSuccessfulPage> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  navigate() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () async {
        cartList.clear();
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingHomepage()));
      },
    );
  }

  @override
  void dispose() {
    cartList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation - 1736119006688.json'),
            Text(
              textAlign: TextAlign.center,
              'Your Order has been placed successfully!',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
