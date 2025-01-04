import 'package:flutter/material.dart';
import 'package:pizz_lecious/feat/cart_detail_view/pages/cart_detail_view_landing_page.dart';
import 'package:pizz_lecious/feat/cart_detail_view/pages/no_products_view.dart';
import 'package:pizz_lecious/feat/global_constants.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: cartList.isEmpty
            ? const NoProductsView()
            : const CartDetailViewLandingPage());
  }
}
